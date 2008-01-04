# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Shell/PEAR-PHP_Shell-0.3.1.ebuild,v 1.1 2008/01/04 13:07:09 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="A shell for PHP with history and tab-completion"
HOMEPAGE="http://jan.kneschke.de/projects/php-shell/"
SRC_URI="http://jan.kneschke.de/assets/2007/2/17/${PEAR_PN}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="auto-completion"

need_php5

pkg_setup() {
	local flags="pcre spl tokenizer"
	use auto-completion && flags="${flags} readline"
	require_php_with_use ${flags}
}

src_install() {
	php-pear-r1_src_install
	dosym /usr/bin/php-shell.sh /usr/bin/php-shell
}
