<?php
namespace app\controllers;

use yii\rest\ActiveController;
use yii\data\ActiveDataProvider;
use app\models\AttributeClassView;
use app\models\ResourceAttribute;
use app\models\ResourceClass;

class Resource_attributeController extends ActiveController
{
    public $modelClass = 'app\models\ResourceAttribute';
    
    public function behaviors()
    {
        return 
        \yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            'corsFilter' => [
                'class' => \yii\filters\Cors::className(),
            ],
        ]);
    }
    public function actionSearch()
    {
    	$GET = \Yii::$app->request->get();
    	if (!empty($GET)) {
    		$model = new $this->modelClass;
    		foreach ($GET as $key => $value) {
    			if (!$model->hasAttribute($key)) {
    				throw new \yii\web\HttpException(404, 'Invalid attribute:' . $key);
    			}
    		}
    		try {
    			$provider = new ActiveDataProvider([
    					'query' => $model->find()->where($GET),
    					'pagination' => false
    			]);
    		} catch (Exception $ex) {
    			throw new \yii\web\HttpException(500, 'Internal server error');
    		}
    
    		if ($provider->getCount() <= 0) {
    			throw new \yii\web\HttpException(404, 'No entries found with this query string');
    		} else {
    			return $provider;
    		}
    	} else {
    		throw new \yii\web\HttpException(400, 'There are no query string');
    	}
    }

    public function actionResourceattribute(){
    $request= \Yii::$app->request->get();

    $resourceattribute = ResourceAttribute::find()
        ->select(['resource_attribute.attribute_id as attribute_Id','resourceattribute.name as attributeName'])
        ->innerJoinWith('resourceClass')->innerJoinWith('resourceAttribute')
        
        // ->andFilterWhere(['like', 'activated', $request['activated']])
        // ->orderBy($sort)
        ->asArray();
        
        $dataProvider = new ActiveDataProvider([
            'query' => $resourceattribute,
            'pagination' => [
                'pageSize' => 30,
                'pageParam' => 'page',
            ],
        ]);
        return $dataProvider;
    }

}