# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/suhosin/suhosin-0.9.16.ebuild,v 1.1 2007/03/04 19:02:59 chtekk Exp $

PHP_EXT_NAME="suhosin"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="Suhosin is an advanced protection system for PHP installations."
HOMEPAGE="http://www.suhosin.org/"
SRC_URI="http://www.hardened-php.net/suhosin/_media/${P}.tgz"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

need_php_by_category

pkg_setup() {
	has_php

	require_php_with_use unicode
}

src_install() {
	php-ext-source-r1_src_install

	dodoc-php CREDITS

	php-ext-base-r1_addtoinifiles ';;;; Logging Configuration'
	php-ext-base-r1_addtoinifiles ';suhosin.log.syslog' 'S_ALL & ~S_SQL'
	php-ext-base-r1_addtoinifiles ';suhosin.log.syslog.facility' 'LOG_USER'
	php-ext-base-r1_addtoinifiles ';suhosin.log.syslog.priority' 'LOG_ALERT'
	php-ext-base-r1_addtoinifiles ';suhosin.log.sapi' 'S_ALL & ~S_SQL'
	php-ext-base-r1_addtoinifiles ';suhosin.log.script' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.log.phpscript' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.log.script.name' ''
	php-ext-base-r1_addtoinifiles ';suhosin.log.phpscript.name' ''
	php-ext-base-r1_addtoinifiles ';suhosin.log.use-x-forwarded-for' 'Off'
	php-ext-base-r1_addtoinifiles ';;;; Executor Options'
	php-ext-base-r1_addtoinifiles ';suhosin.executor.max_depth' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.executor.include.max_traversal' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.executor.include.whitelist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.include.blacklist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.func.whitelist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.func.blacklist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.eval.whitelist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.eval.blacklist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.executor.disable_eval' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.executor.disable_emodifier' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.executor.allow_symlink' 'Off'
	php-ext-base-r1_addtoinifiles ';;;; Misc Options'
	php-ext-base-r1_addtoinifiles ';suhosin.simulation' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.apc_bug_workaround' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.sql.bailout_on_error' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.sql.user_prefix' ''
	php-ext-base-r1_addtoinifiles ';suhosin.sql.user_postfix' ''
	php-ext-base-r1_addtoinifiles ';suhosin.multiheader' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.mail.protect' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.memory_limit' '0'
	php-ext-base-r1_addtoinifiles ';;;; Transparent Encryption Options'
	php-ext-base-r1_addtoinifiles ';suhosin.session.encrypt' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.session.cryptkey' ''
	php-ext-base-r1_addtoinifiles ';suhosin.session.cryptua' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.session.cryptdocroot' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.session.cryptraddr' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.session.checkraddr' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.encrypt' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.cryptkey' ''
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.cryptua' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.cryptdocroot' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.cryptraddr' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.checkraddr' '0'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.cryptlist' ''
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.plainlist' ''
	php-ext-base-r1_addtoinifiles ';;;; Filtering Options'
	php-ext-base-r1_addtoinifiles ';suhosin.filter.action' ''
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_array_depth' '100'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_array_index_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_name_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_totalname_length' '256'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_value_length' '10000'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.max_vars' '100'
	php-ext-base-r1_addtoinifiles ';suhosin.cookie.disallow_nul' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_array_depth' '50'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_array_index_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_name_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_totalname_length' '256'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_value_length' '512'
	php-ext-base-r1_addtoinifiles ';suhosin.get.max_vars' '100'
	php-ext-base-r1_addtoinifiles ';suhosin.get.disallow_nul' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_array_depth' '100'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_array_index_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_name_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_totalname_length' '256'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_value_length' '65000'
	php-ext-base-r1_addtoinifiles ';suhosin.post.max_vars' '200'
	php-ext-base-r1_addtoinifiles ';suhosin.post.disallow_nul' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_array_depth' '100'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_array_index_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_totalname_length' '256'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_value_length' '65000'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_vars' '200'
	php-ext-base-r1_addtoinifiles ';suhosin.request.max_varname_length' '64'
	php-ext-base-r1_addtoinifiles ';suhosin.request.disallow_nul' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.upload.max_uploads' '25'
	php-ext-base-r1_addtoinifiles ';suhosin.upload.disallow_elf' 'On'
	php-ext-base-r1_addtoinifiles ';suhosin.upload.disallow_binary' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.upload.remove_binary' 'Off'
	php-ext-base-r1_addtoinifiles ';suhosin.upload.verification_script' ''
	php-ext-base-r1_addtoinifiles ';suhosin.session.max_id_length' '128'
}
