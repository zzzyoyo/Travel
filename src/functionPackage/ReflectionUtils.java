package functionPackage;


import java.lang.reflect.Field;

import java.lang.reflect.ParameterizedType;

import java.lang.reflect.Type;



public class ReflectionUtils

{

    /**

     * 通过反射，获得Class定义中声明的父类的泛型参数类型

     * 如: public EmployeeDao extends BaseDao<Employee, String>

     * @param clazz

     * @return

     */

    public static<T> Class<T> getSuperGenericType(Class clazz){

        return getSuperClassGenricType(clazz, 0);

    }

    /**

     * 通过反射, 获得定义 Class 时声明的父类的泛型参数的类型

     * 如: public EmployeeDao extends BaseDao<Employee, String>

     * @param clazz

     * @param index

     * @return

     */

    public static Class getSuperClassGenricType(Class clazz,int index)

    {

        Type genType = clazz.getSuperclass();

        if(!(genType instanceof ParameterizedType))

        {

            return Object.class;

        }

        Type [] params = ((ParameterizedType)genType).getActualTypeArguments();

        if(index >= params.length || index < 0){

            return Object.class;

        }

        if(!(params[index] instanceof Class)){

            return Object.class;

        }

        return (Class) params[index];

    }

    public static Field getDeclaredField(Object object,String fieldName)

    {

        Field field = null;

        Class<?> clazz = object.getClass();

        for(;clazz != Object.class;clazz = clazz.getSuperclass())

        {

            try

            {

                field = clazz.getDeclaredField(fieldName);

                return field;

            } catch (Exception e){}

        }

        return null;

    }

    public static void setFieldValue(Object object,String fieldName,Object value)

    {

        Field field = getDeclaredField(object, fieldName);

        field.setAccessible(true);

        try

        {

            field.set(object, value);

        } catch (IllegalArgumentException | IllegalAccessException e)

        {

            e.printStackTrace();

        }

    }

    public static Object getFieldValue(Object object,String fieldName)

    {

        Field field = getDeclaredField(object, fieldName);

        field.setAccessible(true);

        try

        {

            return field.get(object);

        } catch (IllegalArgumentException e)

        {

            e.printStackTrace();

        } catch (IllegalAccessException e)

        {

            e.printStackTrace();

        }

        return null;

    }

}

