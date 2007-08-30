# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/ffmpeg-php/ffmpeg-php-0.5.1.ebuild,v 1.1 2007/08/30 12:46:32 jokey Exp $

PHP_EXT_NAME="ffmpeg"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit depend.php php-ext-source-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension that provides access to movie info."
HOMEPAGE="http://sourceforge.net/projects/ffmpeg-php/"
SRC_URI="mirror://sourceforge/ffmpeg-php/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.4.9_pre1"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	require_gd
}

src_install() {
	php-ext-source-r1_src_install
	dodoc-php CREDITS ChangeLog EXPERIMENTAL TODO
}
