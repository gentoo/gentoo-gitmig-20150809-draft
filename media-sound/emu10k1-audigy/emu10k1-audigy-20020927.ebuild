# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/emu10k1-v0.20a
DESCRIPTION="Drivers, utilities and effects for the SoundBlaster Audigy line of sound cards"
SRC_URI="mirror://sourceforge/emu10k1/emu10k1-v0.20a.tar.bz2"
HOMEPAGE="http://www.sourceforge.net/projects/emu10k1/"
DEPEND="virtual/linux-sources"
RDEPEND="media-sound/aumix"
KEYWORDS="x86 -ppc -sparc "
SLOT="$KV"
LICENSE="GPL-2"

src_unpack()
{
	[ "$KV" = "" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	unpack ${A}
}

src_compile()
{
	make
	make all
	make tools
}

src_install() {
	exeinto /usr/sbin
	doexe ${FILESDIR}/audigy-script
	insinto /etc/audigy
	doins ${FILESDIR}/emu10k1.conf
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

	einfo "To have volume levels save on module unload and restore on module load,"
	einfo "replace the contents of /etc/modules.d/audigy with these 2 lines:"
	einfo " "
	einfo "post-install emu10k1 /usr/sbin/audigy-script restore"
	einfo "pre-remove emu10k1 /usr/sbin/audigy-script save"
	einfo " "
	einfo "then run: update-modules. You must have aumix installed for this to work."
	einfo " "
	einfo "You might also want to add "emu10k1" to your /etc/modules.autoload"
	einfo "and do: rc-update add modules boot."
	einfo " "
	einfo "Use /etc/audigy/emu10k1.conf to configure your card."
	einfo "Run /usr/sbin/audigy-script to apply changes"

}
