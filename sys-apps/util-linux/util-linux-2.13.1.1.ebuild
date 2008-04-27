# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.13.1.1.ebuild,v 1.6 2008/04/27 12:37:07 maekke Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git"
inherit eutils
[[ ${PV} == "9999" ]] && inherit git

MY_PV=${PV/_/-}
MY_P=${PN}-ng-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux-ng/"
if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
else
	SRC_URI="http://www.kernel.org/pub/linux/utils/util-linux-ng/v${PV:0:4}/${MY_P}.tar.bz2
		loop-aes? ( http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.2c.tar.bz2 )"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh sparc x86"
IUSE="crypt loop-aes nls old-linux selinux slang unicode"

RDEPEND="!sys-process/schedutils
	!sys-apps/setarch
	>=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )
	slang? ( sys-libs/slang )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/os-headers"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git_src_unpack
		cd "${S}"
		./autogen.sh || die
	else
		unpack ${A}
		cd "${S}"
		epatch "${FILESDIR}"/${PN}-2.13-uclibc.patch #203711
		use loop-aes && epatch "${WORKDIR}"/loop-AES-*/util-linux-ng-*.diff
		use unicode && sed -i 's:-lncurses:-lncursesw:' */Makefile.in #208976
		epatch "${FILESDIR}"/${PN}-2.13-ioprio-syscalls.patch #190613
	fi
}

src_compile() {
	econf \
		--with-fsprobe=blkid \
		$(use_enable nls) \
		--enable-agetty \
		--enable-cramfs \
		$(use_enable old-linux elvtune) \
		--disable-init \
		--disable-kill \
		--disable-last \
		--disable-mesg \
		--enable-partx \
		--enable-raw \
		--enable-rdev \
		--enable-rename \
		--disable-reset \
		--disable-login-utils \
		--enable-schedutils \
		--disable-wall \
		--enable-write \
		--without-pam \
		$(use_with selinux) \
		$(use_with slang) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS NEWS README* TODO docs/*

	if use crypt ; then
		newinitd "${FILESDIR}"/crypto-loop.initd crypto-loop || die
		newconfd "${FILESDIR}"/crypto-loop.confd crypto-loop || die
	fi
}

pkg_postinst() {
	ewarn "USE=crypt has been changed to USE=loop-aes.  If you need"
	ewarn "support for it, make sure to update your USE accordingly."
}
