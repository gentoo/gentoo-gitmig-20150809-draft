# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.4-r1.ebuild,v 1.1 2006/01/14 22:55:30 genstef Exp $

inherit eutils

DESCRIPTION="powerful text-to-postscript converter"
SRC_URI="http://www.iki.fi/mtr/genscript/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/enscript/enscript.html"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~mips ~ppc64"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="sys-devel/flex
	sys-devel/bison
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/enscript-1.6.3-security.patch
	epatch ${FILESDIR}/enscript-1.6.3-language.patch
	epatch ${FILESDIR}/enscript-catmur.patch
}

src_compile() {
	unset CC
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FAQ.html NEWS README* THANKS TODO
}

pkg_postinst() {
	einfo "Now, customize /etc/enscript.cfg."
}
