# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20031116.ebuild,v 1.2 2004/04/07 21:48:07 vapier Exp $

inherit eutils

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/release/${P}.tar.gz
	http://project.ktug.or.kr/dvipdfmx/snapshot/patch/${P}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="app-text/ptex
	!app-text/tetex
	!app-text/cstetex
	>=sys-apps/sed-4
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6i"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-config-gentoo.diff
	cd src
	epatch ${DISTDIR}/${P}.patch
}

src_install() {
	einstall || die
	dodoc BUGS ChangeLog FONTMAP INSTALL README TODO
}

pkg_postinst() {
	if [ ! `grep -q CMAPINPUTS ${ROOT}/usr/share/texmf/web2c/texmf.cnf` ]; then
		cat >>${ROOT}/usr/share/texmf/web2c/texmf.cnf<<-EOF
		% automatically added by ${PF}.ebuild -- do not edit by hand!
		CMAPINPUTS = .;/opt/Acrobat5/Resource/Font//;/usr/share/xpdf//
		% done
		EOF
	fi
	mktexlsr
}

pkg_postrm() {
	if [ -e ${ROOT}/usr/share/texmf/web2c/texmf.cnf ] ; then
		sed -i -e "/${PF}\.ebuild/,+2d" \
			${ROOT}/usr/share/texmf/web2c/texmf.cnf
	fi
	mktexlsr
}
