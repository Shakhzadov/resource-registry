<?php

namespace app\controllers;

use app\controllers\AppController;
use app\models\ResourceAttribute;
use app\models\AttributeClassView;

class Attribute_class_viewController extends AppController
{
    public $modelClass = 'app\models\AttributeClassView';
    public $resourceClass = 'app\models\ResourceClass';
    public $resourceAttribute = 'app\models\ResourceAttribute';
    
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

    public function actionAttribute() 
    {
        $request = \Yii::$app->request->get();
        $getdata = AttributeClassView::find();
        // print($getdata);
        if(isset($request['value'])){
            $getdata->select(['view_id','class_id','attribute_id'])
            ->andFilterWhere(['like', 'class_id', $request['value']])
            // ->innerJoinWith('resourceAttribute')->innerJoinWith('attribute_id')
            ->asArray();
            return self::buildPagination($getdata, 10); 
        }else{
            $getdata->select(['view_id','class_id','attribute_id'])
            // ->innerJoinWith('resourceAttribute')->innerJoinWith('attribute_id')
            ->asArray();
            return self::buildPagination($getdata, 10); 
        }
    }
}