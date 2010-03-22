# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20100220-r1.ebuild,v 1.2 2010/03/22 14:02:08 pacho Exp $

inherit emul-linux-x86

SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2
	http://dev.gentoo.org/~pacho/emul-linux-x86-${PV}/libmikmod.so.2"

LICENSE="as-is BSD GPL-2 LGPL-2 LGPL-2.1 gsm"
KEYWORDS="-* amd64"
IUSE="alsa pulseaudio"

RDEPEND="pulseaudio? ( media-sound/pulseaudio )
	~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}"

QA_DT_HASH="usr/lib32/.*"

src_unpack() {
	_ALLOWED="${S}/etc/env.d"
	use alsa && _ALLOWED="${_ALLOWED}|${S}/usr/bin/aoss"
	ALLOWED="(${_ALLOWED})"

	emul-linux-x86_src_unpack

	if use alsa; then
		mv -f "${S}"/usr/bin/aoss{,32} || die
	fi

	# libs without the rest of pulseaudio cause problems, bug 302003
	if ! use pulseaudio; then
		rm -rf $(find "${S}" -name '*pulse*' -not -name '*impulse*') || die
	fi
}

src_install() {
	emul-linux-x86_src_install
	insinto /usr/lib32/
	doins "${DISTDIR}"/libmikmod.so.2 || die
}
