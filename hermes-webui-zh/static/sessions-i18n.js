/**
 * Hermes WebUI 中文界面 - 会话管理翻译层
 * 基于 sessions.js v0.39.0 汉化
 * 将此文件内容追加到 sessions.js 末尾，或在 index.html 中替换 sessions.js 引用
 */

// 覆盖原有全局函数中的英文字符串
const _origConfirm = window.confirm;
window.confirm = function(msg) {
  const ZH_MAP = {
    'Delete this conversation?': '确定删除此对话？',
    'Delete project "': '确定删除项目 "',
    '? Sessions will be unassigned but not deleted.': '" 吗？会话将取消分配但不会被删除。',
  };
  for (const [en, zh] of Object.entries(ZH_MAP)) {
    if (msg.includes(en)) return _origConfirm(msg.replace(en, ZH_MAP[en]));
  }
  return _origConfirm(msg);
};

const _origShowToast = window.showToast;
window.showToast = function(msg) {
  const ZH_MAP = {
    'Conversation deleted': '对话已删除',
    'Session archived': '会话已归档',
    'Session restored': '会话已恢复',
    'Session duplicated': '会话已复制',
    'Project created': '项目已创建',
    'Project renamed': '项目已重命名',
    'Project deleted': '项目已删除',
    'Moved to ': '已移动到 ',
    'Removed from project': '已从项目中移除',
    'Created "': '已创建 "',
    '" and moved session': '" 并移动了会话',
    'Rename failed: ': '重命名失败：',
    'Pin failed: ': '置顶失败：',
    'Archive failed: ': '归档失败：',
    'Duplicate failed: ': '复制失败：',
    'Delete failed: ': '删除失败：',
    'Save failed: ': '保存失败：',
  };
  for (const [en, zh] of Object.entries(ZH_MAP)) {
    if (msg.includes(en)) return _origShowToast(msg.replace(en, ZH_MAP[en]));
  }
  return _origShowToast(msg);
};
