# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/emu10k1/emu10k1-0.20a.ebuild,v 1.3 2002/12/09 04:26:14 manson Exp $

MY_P="${P/-/-v}"
DESCRIPTION="Drivers, utilities, and effects for Sound Blaster cards (SBLive!, SB512, Audigy)"
SRC_URI="mirror://sourceforge/emu10k1/${MY_P}.tar.bz2"
HOMEPAGE="http://www.sourceforge.net/projects/emu10k1/"

DEPEND="virtual/linux-sources"
RDEPEND="media-sound/aumix"

KEYWORDS="x86 -ppc -sparc  -alpha"
SLOT="${KV}"
LICENSE="GPL-2"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	[ -z "$KV" ] && die "Couldn't detect kernel version.  Does /usr/src/linux exist?"
	return 0
}

src_compile() {
	make || die "make failed"
	make all || die "make all failed"
	make tools || die "make tools failed"
}

src_install() {
	insinto /etc/modules.d
	newins ${FILESDIR}/modules-emu10k1 emu10k1

	# first install the main parts
	make DESTDIR=${D} install || die "could not install"

	# now fix up the script so it'll install into /usr and not /usr/local
	for f in ${S}/utils/{Makefile.config,scripts/{audigy,emu}-script} ; do
		cp ${f} ${f}.old
		sed -e 's:/usr/local:/usr:g' ${f}.old > ${f}
	done
	make DESTDIR=${D} install-tools || die "could not install tools"

	# clean up the /usr/etc directory
	cd ${D}/usr/etc
	mv `find -type f -perm +1` ../bin/
	mv * ${D}/etc/
	dosed 's:$BASE_PATH/etc:/etc:g' /usr/bin/emu-script
	cd ${D}
	rm -rf ${D}/usr/etc
}
