# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/scsh/scsh-0.6.6.ebuild,v 1.1 2005/08/09 18:18:29 mkennedy Exp $

inherit eutils scsh

MV="${PV%*.*}"

DESCRIPTION="Unix shell embedded in Scheme"
HOMEPAGE="http://www.scsh.net/"
SRC_URI="ftp://ftp.scsh.net/pub/scsh/${MV}/${P}.tar.gz"
LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=""

src_unpack() {
	# SCSH_LIB_DIRS='$SCSH_SCSH_PATH'
	set_layout
	set_path_variables
	unpack ${A}
	cd ${S}
	if ! use scsh; then
		epatch ${FILESDIR}/0.6.6-Makefile.in-doc-dir-gentoo.patch || die
	fi
}

src_compile() {
	scsh_conf="--prefix=/usr
		--libdir=/usr/$(get_libdir)
		--includedir=/usr/include
		--with-lib-dirs-list=${SCSH_SCSH_PATH} "
	econf ${scsh_conf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /etc/env.d
	cat >${D}/etc/env.d/50scsh <<EOF
SCSH_LIB_DIRS='${SCSH_LIB_DIRS}'
EOF
}
