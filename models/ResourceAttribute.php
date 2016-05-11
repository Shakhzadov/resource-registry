<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "resource_attribute".
 *
 * @property integer $attribute_id
 * @property string $name
 *
 * @property AttributeClassView[] $attributeClassViews
 * @property Parameter[] $parameters
 */
class ResourceAttribute extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'resource_attribute';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 60],
            [['global_status'], 'required'],
            [['global_status'], 'integer']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'attribute_id' => 'Attribute ID',
            'name' => 'Name',
            'global_status' => 'Global Status'
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAttributeClassViews()
    {
        return $this->hasMany(AttributeClassView::className(), ['attribute_id' => 'attribute_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getParameters()
    {
        return $this->hasMany(Parameter::className(), ['attribute_id' => 'attribute_id']);
    }
}
