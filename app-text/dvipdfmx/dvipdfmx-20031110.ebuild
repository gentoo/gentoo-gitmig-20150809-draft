# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20031110.ebuild,v 1.3 2004/03/11 19:47:42 usata Exp $

IUSE=""

DESCRIPTION="DVI to PDF translator with multi-byte character support"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/release/${P}.tar.gz"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"

KEYWORDS="x86 alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="app-text/ptex
	!app-text/tetex
	!app-text/cstetex
	>=sys-apps/sed-4
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6i"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-config-gentoo.diff
}

src_install () {
	einstall || die

	dodoc BUGS COPYING ChangeLog FONTMAP INSTALL README TODO
}

pkg_postinst () {

	einfo
	einfo "Automatically adding CMAPINPUTS to /usr/share/texmf/web2c/texmf.cnf"
	if [ ! `grep -q CMAPINPUTS /usr/share/texmf/web2c/texmf.cnf` ]; then
		cat >>/usr/share/texmf/web2c/texmf.cnf<<-EOF
		% automatically added by ${PF}.ebuild -- do not edit by hand!
		CMAPINPUTS = .;/opt/Acrobat5/Resource/Font//;/usr/share/xpdf//
		% done
		EOF
	fi

	sleep 3
	einfo "Done."
	einfo

	mktexlsr
}

pkg_postrm () {
	if [ -e /usr/share/texmf/web2c/texmf.cnf ] ; then
		sed -i -e "/${PF}\.ebuild/,+2d" \
			/usr/share/texmf/web2c/texmf.cnf
	fi

	mktexlsr
}
