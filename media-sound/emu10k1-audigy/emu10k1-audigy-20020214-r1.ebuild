# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/emu10k1-audigy/emu10k1-audigy-20020214-r1.ebuild,v 1.1 2002/07/16 20:18:16 drobbins Exp $

S=${WORKDIR}/emu10k1-audigy
DESCRIPTION="Drivers, utilities and effects for the SoundBlaster Audigy line of sound cards"
SRC_URI="mirror://sourceforge/emu10k1/audigy-driver-2002-02-14.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/emu10k1/"
DEPEND="virtual/linux-sources"
RDEPEND="media-sound/aumix"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="$KV"
LICENSE="GPL-2"

src_unpack()
{
	[ "$KV" = "" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	unpack ${A}
	cp ${FILESDIR}/config ${S}
}

src_compile() 
{
	make
	make all
	make tools
}

src_install() {
	dodir /etc/audigy
	dodir /usr/sbin
	insinto /etc/audigy
	doins ${FILESDIR}/emu10k1.conf
	exeinto /usr/sbin
	doexe ${FILESDIR}/audigy-script
	insinto /etc/modules.d
	newins ${FILESDIR}/modules-audigy audigy
	make DESTDIR=${D} install
	insinto /usr/share/audigy/effects
	cd ${S}/utils/as10k1
	doins effects/*.bin
	dobin as10k1
	doman as10k1.1
	cd ${S}/utils/mixer
	dosbin emu-dspmgr emu-config
	doman doc/*.1
}

pkg_postinst() {
	if [ -e /usr/sbin/update-modules ]
	then
		${ROOT}/usr/sbin/update-modules
	fi
}
