<?php
/**
 * JComments - Joomla Comment System
 *
 * @version 3.0
 * @package JComments
 * @author Sergey M. Litvinov (smart@joomlatune.ru)
 * @copyright (C) 2006-2013 by Sergey M. Litvinov (http://www.joomlatune.ru)
 * @license GNU/GPL: http://www.gnu.org/copyleft/gpl.html
 */

defined('_JEXEC') or die;

class JCommentsModelObject
{
	public static function getObjectInfo($object_id, $object_group, $language)
	{
		$db = JFactory::getDbo();

		$query = $db->getQuery(true)
			->select('*')
			->from($db->quoteName('#__jcomments_objects'))
			->where($db->quoteName('object_id') . ' = ' . $db->Quote($object_id))
			->where($db->quoteName('object_group') . ' = ' . $db->Quote($object_group))
			->where($db->quoteName('lang') . ' = ' . $db->Quote($language));

		$db->setQuery($query);
		$info = $db->loadObject();

		return empty($info) ? false : $info;
	}

	public static function setObjectInfo($objectId, $info)
	{
		$db = JFactory::getDbo();

		if (!empty($objectId)) {
			$query = $db->getQuery(true)
				->clear()
				->update($db->quoteName('#__jcomments_objects'))
				->set($db->quoteName('access') . ' = ' . (int) $info->access)
				->set($db->quoteName('userid') . ' = ' . (int) $info->userid)
				->set($db->quoteName('expired') . ' = ' . 0)
				->set($db->quoteName('modified') . ' = ' . $db->Quote(JFactory::getDate()->toSql()))
				->set($db->quoteName('title') . ' = ' . (empty($info->title) ? "" : $db->Quote($info->title)))
				->set($db->quoteName('link') . ' = ' . (empty($info->link) ? "" : $db->Quote($info->link)))
				->set($db->quoteName('category_id') . ' = ' . (empty($info->category_id) ? "" : (int) $info->category_id))
				->where('id = ' . (int) $objectId);

		} else {
			$query = $db->getQuery(true)
				->clear()
				->insert('#__jcomments_objects')
				->columns(
					array($db->quoteName('object_id'), $db->quoteName('object_group'), 
					$db->quoteName('category_id'), $db->quoteName('lang'), 
					$db->quoteName('title'), $db->quoteName('link'), 
					$db->quoteName('access'), $db->quoteName('userid'), 
					$db->quoteName('expired'), $db->quoteName('modified'))
					)
				->values(
					(int) $info->object_id . ', ' . $db->quote($info->object_group) . ', ' . 
					(int) $info->category_id . ', ' . $db->Quote($info->lang) . ', ' .
					$db->Quote($info->title) . ', ' . $db->Quote($info->link) . ', ' . 
					(int) $info->access . ', ' . (int) $info->userid . ', ' . 0 . ', ' .
					$db->Quote(JFactory::getDate()->toSql())
					);
		}

		$db->setQuery($query);
		$db->execute();
	}

	public static function IsEmpty($object)
	{
		return empty($object->title) && empty($object->link);
	}
}
