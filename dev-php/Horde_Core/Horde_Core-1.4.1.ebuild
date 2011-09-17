# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Core/Horde_Core-1.4.1.ebuild,v 1.1 2011/09/17 10:53:53 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Core Framework libraries"
LICENSE="GPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/get/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0

	=dev-php/Horde_ActiveSync-1*
	=dev-php/Horde_Alarm-1*
	=dev-php/Horde_Auth-1*
	=dev-php/Horde_Autoloader-1*
	=dev-php/Horde_Browser-1*
	=dev-php/Horde_Cache-1*
	=dev-php/Horde_Cli-1*
	=dev-php/Horde_Compress-1*
	=dev-php/Horde_Controller-1*
	=dev-php/Horde_Data-1*
	=dev-php/Horde_Date-1*
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Group-1*
	=dev-php/Horde_History-1*
	=dev-php/Horde_Injector-1*
	=dev-php/Horde_Lock-1*
	=dev-php/Horde_Log-1*
	=dev-php/Horde_LoginTasks-1*
	=dev-php/Horde_Mime-1*
	=dev-php/Horde_Mime_Viewer-1*
	=dev-php/Horde_Notification-1*
	=dev-php/Horde_Perms-1*
	=dev-php/Horde_Prefs-1*
	=dev-php/Horde_Secret-1*
	=dev-php/Horde_Serialize-1*
	=dev-php/Horde_SessionHandler-1*
	=dev-php/Horde_Share-1*
	=dev-php/Horde_Support-1*
	=dev-php/Horde_Template-1*
	=dev-php/Horde_Token-1*
	=dev-php/Horde_Text_Filter-1*
	=dev-php/Horde_Text_Filter_Csstidy-1*
	=dev-php/Horde_Translation-1*
	=dev-php/Horde_Url-1*
	=dev-php/Horde_Util-1*
	=dev-php/Horde_View-1*"
RDEPEND="${DEPEND}"
