# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.13_rc3.ebuild,v 1.1 2007/08/10 14:40:19 vapier Exp $

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git"
inherit eutils git

MY_PV=${PV/_/-}
MY_P=${PN}-ng-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux-ng/"
if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
else
	SRC_URI="http://www.kernel.org/pub/linux/utils/util-linux-ng/v${PV:0:4}/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls old-linux selinux"

RDEPEND="!sys-process/schedutils
	!sys-apps/setarch
	>=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )"
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
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS NEWS README* TODO docs/*
}
