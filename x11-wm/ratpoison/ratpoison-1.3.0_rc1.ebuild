# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.3.0_rc1.ebuild,v 1.5 2004/03/30 05:32:42 weeve Exp $

inherit elisp-common

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://ratpoison.sourceforge.net/"
LICENSE="GPL-2"

MY_P="${PN}-${PV/_/-}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="emacs"
S=${WORKDIR}/${MY_P}

DEPEND="virtual/x11
	emacs? ( virtual/emacs )"

SITEFILE=50ratpoison-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}/contrib
	epatch ${FILESDIR}/ratpoison.el-gentoo.patch
}

src_compile() {
	if [ "${ARCH}" = "amd64" ]
	then
		libtoolize -c -f
	fi
	econf
	emake CFLAGS="${CFLAGS} -I/usr/X11R6/include" || die
	if use emacs; then
		cd contrib && elisp-comp ratpoison.el
	fi
}

src_install() {
	einstall
	cat >ratpoison <<EOF
#!/bin/bash
exec /usr/bin/ratpoison
EOF
	exeinto /etc/X11/Sessions
	doexe ratpoison

	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc contrib/{genrpbindings,split.sh} doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf $D/usr/share/{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
