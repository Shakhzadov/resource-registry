<?php
namespace app\controllers;

use app\controllers\AppController;
use app\models\User;
use app\models\Community;

class CommunityController extends AppController
{
	public $modelClass = 'app\models\Community';
	
	public function actionShow()
	{
		$request= \Yii::$app->request->get();
		$community = Community::find();
		
		$community->select(['name', 'prefix', 'notes', 'community_id', 'isactive'])
        ->andFilterWhere(['like', 'name', $request['value']])
        ->orderBy('name')
        ->asArray();

        return self::buildPagination($community);
	}

	public function actionAddcomm()
    {
        // add Community controller
        if (!$post = \Yii::$app->getRequest()->getBodyParams()) {
            throw new \yii\web\HttpException(400, 'Дані не отримані');
        }
        $communityModel = new Community();
        if ($communityModel->findByCommunityName($post['com_name'])){
            throw new \yii\web\HttpException(400, 'Користувач з таким логіном уже існує');
        }
        $com_name = $post['com_name'];
        $com_num = $post['com_num'];
        $com_adds = $post['com_adds'];

        $communityModel->name = $com_name;
        $communityModel->prefix = $com_num;
        $communityModel->notes = $com_adds;
        $communityModel->isactive = 1;
        if (!$communityModel->save()){
            foreach($communityModel->errors as $key){
                $errorMessage .= $key[0];
            }
            throw new \yii\web\HttpException(422,$errorMessage);
        }
    }
}