# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devel-chroots/devel-chroots-2.1.0.ebuild,v 1.3 2007/07/12 01:05:42 mr_bones_ Exp $

DESCRIPTION="Gentoo Developer chroots installation/configuration"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/docs/devel-chroots.xml"

SRC_URI="http://85.214.109.84/~pappy/gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

RDEPEND="dev-lang/perl
		 dev-perl/XML-LibXML
		 dev-perl/libwww-perl
		 sys-process/lsof
		 app-misc/screen"

src_install() {
	doconfd "${S}/etc/conf.d/${PN}.conf.sample"
	doinitd "${S}/etc/init.d/${PN}"
	dosbin "${S}/usr/sbin/${PN}"
}
