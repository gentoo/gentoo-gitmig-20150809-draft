# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20030813.ebuild,v 1.3 2003/09/08 17:11:35 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="DVI to PDF translator with multi-byte character support"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/${P}.tar.gz"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"

KEYWORDS="x86 alpha ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="app-text/ptex
	!app-text/tetex
	>=sys-apps/sed-4
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	>=dev-libs/openssl-0.9.6i"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install () {
	einstall || die

	dodoc BUGS COPYING ChangeLog FONTMAP INSTALL README TODO
}

pkg_postinst () {
	#einfo
	#einfo "You need modify /usr/share/texmf/web2c/texmf.cnf"
	#einfo "in order to convert DVI correctly."
	#einfo "For example, if you have Acrobat Reader 5 and"
	#einfo "Asian fonts installed, you may want to add"
	#einfo
	#einfo "CMAPINPUTS = .;/opt/Acrobat5/Resource/Font//"
	#einfo
	#einfo "If you have xpdf installed,"
	#einfo
	#einfo "you may want to add"
	#einfo
	#einfo "CMAPINPUTS = .;/usr/share/xpdf//"
	#einfo
	#einfo "respectively."
	#einfo

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
