# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.4.0.ebuild,v 1.2 2004/10/18 22:02:42 gustavoz Exp $

IUSE="nls debug"

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Visual Development Kit used for VDK Builder."
HOMEPAGE="http://vdkbuilder.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-libs/vdk-2.4.0"

custom_cflags() {
	for files in *
	do
		if [ -e ${files}/Makefile ]
		then
			sed -e "s/CFLAGS = .*/CFLAGS = ${CFLAGS} -I../include/" -i ${files}/Makefile
			sed -e "s/CXXFLAGS = .*/CFLAGS = ${CXXFLAGS} -I../include/" -i ${files}/Makefile
		fi
	done
}

src_compile() {

	cd ${S}

	local myconf=""

	use debug \
		&& myconf="${myconf} --enable-devel=yes" \
		|| myconf="${myconf} --enable-devel=no"

	econf \
		$(use_enable nls) \
		--with-gnu-ld \
		--disable-vdktest \
		${myconf} || die "econf failed"

	custom_cflags

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
