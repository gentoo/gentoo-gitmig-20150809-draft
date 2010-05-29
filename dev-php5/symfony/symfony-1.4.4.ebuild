# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/symfony/symfony-1.4.4.ebuild,v 1.2 2010/05/29 18:45:33 mabi Exp $

EAPI="2"
inherit php-pear-lib-r1

DESCRIPTION="Open-source PHP5 professional web framework"
HOMEPAGE="http://www.symfony-project.com/"
SRC_URI="http://pear.symfony-project.com/get/${P}.tgz"

LICENSE="MIT LGPL-2.1 BSD BSD-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/php:5[cli,ctype,session,simplexml,tokenizer,xml]
	|| ( <dev-lang/php-5.3.1[pcre,reflection,spl] >=dev-lang/php-5.3.1 )
	dev-php/pear"
RDEPEND="${DEPEND}"
