# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/emu10k1/emu10k1-0.20a-r4.ebuild,v 1.1 2003/03/07 15:35:10 vapier Exp $

MY_P="${P/-/-v}"
DESCRIPTION="Drivers, utilities, and effects for Sound Blaster cards (SBLive!, SB512, Audigy)"
SRC_URI="mirror://sourceforge/emu10k1/${MY_P}.tar.bz2"
HOMEPAGE="http://www.sourceforge.net/projects/emu10k1/"

DEPEND="virtual/linux-sources"
RDEPEND="media-sound/aumix"

KEYWORDS="x86 -ppc -sparc -alpha"
SLOT="${KV}"
LICENSE="GPL-2"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	[ -z "$KV" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	return 0
}

src_compile() {
	echo "SEQUENCER_SUPPORT := y" > config
	echo "MODVERSIONS := y" >> config
	echo "DBGEMU := n" >> config

	export KERNEL_SOURCE=/usr/src/linux
	make || die "make failed"
	make all || die "make all failed"
	make tools || die "make tools failed"
}

src_install() {
	insinto /etc/modules.d
	newins ${FILESDIR}/modules-emu10k1 emu10k1

	# first install the main parts
	make DESTDIR=${D} install || die "could not install"
	rm -f docs/*patch
	dodoc docs/*

	# now fix up the script so it'll install into /usr and not /usr/local
	for f in ${S}/utils/{Makefile.config,scripts/{audigy,emu}-script} ; do
		cp ${f} ${f}.old
		sed -e 's:/usr/local:/usr:g' ${f}.old > ${f}
	done
	make man_prefix=${D}/usr/share/man DESTDIR=${D} install-tools || die "could not install tools"

	# clean up the /usr/etc directory
	cd ${D}/usr/etc
	mv `find -type f -perm +1` ../bin/
	mv * ${D}/etc/
	cd ${D}
	rm -rf ${D}/usr/etc

	# add wrapper script to handle audigy and emu cards
	dobin ${FILESDIR}/emu10k1-script
	cd ${D}/etc
	cp emu10k1.conf ${T}/
	{
		cat ${FILESDIR}/emu10k1.conf-gentoo-header
		cat ${T}/emu10k1.conf
	} > emu10k1.conf

	# clean up the scripts
	dosed 's:$BASE_PATH/etc:/etc:g' /usr/bin/emu-script
	dosed 's:$BASE_PATH/etc:/etc:g' /usr/bin/audigy-script
	dosed 's:.aumixrc:aumixrc:g' /usr/bin/audigy-script
	dosed 's:/bin/aumix-minimal:/usr/bin/aumix:g' /usr/bin/audigy-script
	dosed 's:/etc/.aumixrc:/etc/aumixrc:g' /usr/bin/audigy-script

	# change default settings
	dosed 's:AC3PASSTHROUGH=no:AC3PASSTHROUGH=yes:' /etc/emu10k1.conf
	dosed 's:ANALOG_FRONT_BOOST=no:ANALOG_FRONT_BOOST=yes:' /etc/emu10k1.conf
	dosed 's:SURROUND=no:SURROUND=yes:' /etc/emu10k1.conf
}

pkg_postinst() {
	/sbin/depmod -a
	/sbin/update-modules

	einfo "In order for the module to work correctly you must"
	einfo "Enable the following options in your kernel:"
	echo
	einfo "Sound/Sound card support    (module or builtin)"
	einfo "Sound/OSS sound modules     (module or builtin)"
	echo
	einfo "In addition, ensure that the following modules are"
	einfo "*not* built in to your kernel, or are at least"
	einfo "built as modules are not currently loaded."
	echo
	einfo "Sound/Creative SBLive! (EMU10K1)  (disabled or module)"
	einfo "Sound/Creative SBLive! MIDI       (disabled or module)"
	echo
	einfo "If you have not yet done this, rebuild and install"
	einfo "your kernel modules and re-emerge this package."
}
