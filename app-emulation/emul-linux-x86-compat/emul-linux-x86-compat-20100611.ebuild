# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-compat/emul-linux-x86-compat-20100611.ebuild,v 1.3 2010/06/27 13:13:35 ssuominen Exp $

inherit emul-linux-x86 eutils multilib
DESCRIPTION="32 bit lib-compat, and also libgcc_s and libstdc++ from gcc 3.3 and 3.4 for non-multilib systems"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
RESTRICT="strip"
IUSE="multilib"

DEPEND=""
RDEPEND="multilib? ( sys-libs/libstdc++-v3 )"

S=${WORKDIR}

QA_TEXTRELS_amd64="usr/lib32/libg++.so.2.7.2.8
	usr/lib32/libstdc++.so.2.7.2.8"
QA_DT_HASH="usr/lib32/.*"

src_unpack() {
	emul-linux-x86_src_unpack
	if has_multilib_profile ; then
		rm -rf "${S}/usr/lib32/libstdc++.so.5.0.7" \
			"${S}/usr/lib32/libstdc++.so.5" || die
	fi
}

src_install() {
	emul-linux-x86_src_install
	doenvd "${FILESDIR}/99libstdc++32" || die
}
