# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-0.9.2.ebuild,v 1.10 2004/07/24 05:44:34 eradicator Exp $

IUSE=""

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2 LGPL-2.1"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set ALSA_CARDS
# environment to a space-separated list of drivers that you want to build.
# For example:
#
#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
#
[ x"${ALSA_CARDS}" = x ] && ALSA_CARDS=all

# Need the baselayout 1.7.9 or newer for the init script to work correctly.
DEPEND="sys-devel/autoconf
	virtual/linux-sources
	>=sys-apps/portage-1.9.10"
RDEPEND=">=sys-apps/baselayout-1.7.9"
PROVIDE="virtual/alsa"

SLOT="0.9"
KEYWORDS="x86 ~ppc -sparc"

SRC_URI="mirror://alsaproject/driver/${P}.tar.bz2"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Some *broken* Gentoo packages install stuff in /etc/rc.d/init.d
	# instead of /etc/init.d.  However, this causes alsa's installer
	# to do the same foolish thing.	 This *hack* inibits the problem.
	# I filed a bug report about this with the ALSA people:
	# http://sourceforge.net/tracker/?func=detail&aid=551668&group_id=27464&atid=390601
	# Arcady Genkin <agenkin@thpoon.com>
	sed -e 's:/etc/rc.d/init.d:/etc/init.d:' < Makefile > Makefile.hacked
	mv Makefile.hacked Makefile

}


src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-kernel="${ROOT}usr/src/linux" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-oss=yes \
		--with-cards="${ALSA_CARDS}" \
		|| die "./configure failed"

	make || die "Parallel Make Failed"
}


src_install() {
	dodir /usr/include/sound
	dodir /etc/init.d
	make DESTDIR=${D} install || die

	dodoc CARDS-STATUS COPYING FAQ INSTALL README WARNING TODO doc/*

	insinto /etc/modules.d
	newins ${FILESDIR}/alsa-modules.conf-rc alsa
	exeinto /etc/init.d
	doexe ${FILESDIR}/alsasound
}

pkg_postinst() {
	if [ "${ROOT}" = / ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	einfo
	einfo "You need to edit file /etc/modules.d/alsa according to your"
	einfo "hardware configuration."
	einfo
	einfo "If you are going to be using the 'alsasound' init script, make sure"
	einfo "that you add it to the 'boot' runlevel (not 'default')."
	einfo
	einfo "Also, remember that all mixer channels will be MUTED by default."
	einfo "Use 'alsamixer' program to unmute them."
	einfo
}

