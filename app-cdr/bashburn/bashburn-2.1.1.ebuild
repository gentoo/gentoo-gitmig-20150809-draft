# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bashburn/bashburn-2.1.1.ebuild,v 1.2 2007/08/13 20:02:23 dertobi123 Exp $

MY_P=BashBurn-${PV}

DESCRIPTION="cd burning shell script"
HOMEPAGE="http://bashburn.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="dvdr"

DEPEND="virtual/libc
	virtual/cdrtools
	>=app-cdr/cdrdao-1.1.7
	dvdr? ( app-cdr/dvd+rw-tools )
	virtual/mpg123
	media-sound/lame
	media-sound/vorbis-tools
	media-sound/normalize
	media-libs/flac
	virtual/eject"

RDEPEND="app-shells/bash"

S=${WORKDIR}/${MY_P}

src_compile() {
	echo "Skipping Compile"
}

src_install() {
	sed -i "s:export BBCONFFILE='/etc/bashburnrc':export BBCONFFILE=/etc/bashburn/bashburnrc:g" BashBurn.sh
	sed -i "s:BBROOTDIR\:.*:BBROOTDIR\: /opt/BashBurn:g" bashburnrc

	dodir /etc/bashburn
	dodir /opt/BashBurn
	dodir /usr/bin

	mv {burning,config,convert,func,menus,misc,lang} ${D}/opt/BashBurn

	exeinto /opt/BashBurn
	doexe BashBurn.sh || die
	cp bashburnrc ${D}/etc/bashburn
	fperms 655 /etc/bashburn/bashburnrc
	ln -sf /opt/BashBurn/BashBurn.sh ${D}/usr/bin/bashburn

	dodoc README HOWTO FAQ ChangeLog TODO
}
