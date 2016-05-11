<?php

namespace app\controllers;

use yii\rest\ActiveController;
use yii\data\ActiveDataProvider;
use app\models\AttributeClassView;
use app\models\ResourceAttribute;
use app\models\ResourceClass;


class Attribute_class_viewController extends ActiveController
{
    public $modelClass = 'app\models\AttributeClassView';
    
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

    public function actionAttributeclassview(){
    $request= \Yii::$app->request->get();

    $classattribute = AttributeClassView::find()
        ->select(['attribute_class_view.class_id as classId','resource_class.name as className','attribute_class_view.attribute_id as attributeId', 'resource_attribute.name as attributeName'])
        ->innerJoinWith('resourceClass')->innerJoinWith('resourceAttribute')
        // ->andFilterWhere($filters)
        // ->andFilterWhere(['like', 'activated', $request['activated']])
        // ->orderBy($sort)
        ->asArray();
        
        $dataProvider = new ActiveDataProvider([
            'query' => $classattribute,
            'pagination' => [
                'pageSize' => 30,
                'pageParam' => 'page',
            ],
        ]);
        return $dataProvider;
    }
}