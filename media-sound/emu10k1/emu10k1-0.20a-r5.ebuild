# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/emu10k1/emu10k1-0.20a-r5.ebuild,v 1.4 2004/02/05 07:44:07 eradicator Exp $

MY_P="${P/-/-v}"
DESCRIPTION="Drivers, utilities, and effects for Sound Blaster cards (SBLive!, SB512, Audigy)"
SRC_URI="mirror://sourceforge/emu10k1/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.sourceforge.net/projects/emu10k1/"

DEPEND="virtual/linux-sources"
RDEPEND="media-sound/aumix"

KEYWORDS="-* x86"
SLOT="${KV}"
LICENSE="GPL-2"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	[ -z "$KV" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	return 0
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch for GCC 3.3 
	epatch ${FILESDIR}/${P}-gcc3.3.patch.gz || die
}

src_compile() {
	echo "SEQUENCER_SUPPORT := y" > config
	echo "MODVERSIONS := y" >> config
	echo "DBGEMU := n" >> config

	# Unset ARCH to prevent conflict.  See bug #40424
	unset ARCH

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
	dodoc docs/* ${FILESDIR}/README.gentoo

	# now fix up the script so it'll install into /usr and not /usr/local
	for f in ${S}/utils/{Makefile.config,scripts/emu-script} ; do
		cp ${f} ${f}.old
		sed -e 's:/usr/local:/usr:g' ${f}.old > ${f}
	done
	make man_prefix=${D}/usr/share/man DESTDIR=${D} install-tools || die "could not install tools"

	# clean up the /usr/etc directory, movind stuff to /usr/bin...
	cd ${D}/usr/etc
	mv `find -type f -perm +1` ../bin/
	mv * ${D}/etc/
	cd ${D}
	rm -rf ${D}/usr/etc

	# add our special fixed audigy-script. Yes, the one in the driver package is b0rked and should
	# not be used until you're absolutely sure it's superior to this one. Much thanks to
	# Jonathan Boler (tenpin22@blueyonder.co.uk) for this excellent fixed version.
	dobin ${FILESDIR}/audigy-script || die

	# add wrapper script to handle audigy and emu cards
	dobin ${FILESDIR}/emu10k1-script || die
	cd ${D}/etc
	cp emu10k1.conf ${T}/
	{
		cat ${FILESDIR}/emu10k1.conf-gentoo-header
		cat ${T}/emu10k1.conf
	} > emu10k1.conf

	# clean up the scripts
	dosed 's:$BASE_PATH/etc:/etc:g' /usr/bin/emu-script
	dosed 's:\.aumixrc:aumixrc:g' /usr/bin/emu-script
	# set tone control defaults to 50 (neutral)
	dosed 's:68:50:g' /usr/bin/emu-script
	# the audigy script is a local copy in ${FILESDIR} and has already been fixed up.

	# change default settings
	dosed 's:AC3PASSTHROUGH=no:AC3PASSTHROUGH=yes:' /etc/emu10k1.conf
	dosed 's:ANALOG_FRONT_BOOST=no:ANALOG_FRONT_BOOST=yes:' /etc/emu10k1.conf
	dosed 's:SURROUND=no:SURROUND=yes:' /etc/emu10k1.conf

}

pkg_postinst() {
	#update-modules handles depmod -a for us
	if [ -e /sbin/update-modules ]
	then
		/sbin/update-modules
	else
		/usr/sbin/update-modules
	fi
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
