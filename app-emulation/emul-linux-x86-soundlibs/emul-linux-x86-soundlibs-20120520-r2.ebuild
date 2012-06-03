# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-20120520-r2.ebuild,v 1.1 2012/06/03 09:19:40 hwoarang Exp $

EAPI="4"

inherit emul-linux-x86 toolchain-funcs

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2.1 LGPL-2 as-is gsm public-domain"
KEYWORDS="-* ~amd64"
IUSE="alsa pulseaudio"

RDEPEND="pulseaudio? ( media-sound/pulseaudio )
	~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}"

QA_DT_HASH="usr/lib32/.*"

src_prepare() {
	_ALLOWED="${S}/etc/env.d"
	use alsa && _ALLOWED="${_ALLOWED}|${S}/usr/bin/aoss"
	ALLOWED="(${_ALLOWED})"

	emul-linux-x86_src_prepare

	if use alsa; then
		mv -f "${S}"/usr/bin/aoss{,32} || die
	fi

	# libs without the rest of pulseaudio cause problems, bug 302003
	if ! use pulseaudio; then
		rm -f "${S}"/usr/lib32/libpulse{,-simple}.so*
		echo 'int main() { }' > "${T}"/tmp.c
		$(tc-getCC) -m32 -shared -Wl,-soname -Wl,libpulse.so.0 "${T}"/tmp.c -o "${S}"/usr/lib32/libpulse.so.0
		$(tc-getCC) -m32 -shared -Wl,-soname -Wl,libpulse-simple.so.0 "${T}"/tmp.c -o "${S}"/usr/lib32/libpulse-simple.so.0
	fi
}
