# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_dotfile/pam_dotfile-0.7-r1.ebuild,v 1.2 2006/04/27 00:27:35 halcy0n Exp $

inherit eutils pam

MY_P="${P/_beta/beta}"
S="${WORKDIR}/${MY_P}"

PATCHLEVEL="1"
DESCRIPTION="pam module to allow password-storing in \$HOME/dotfiles"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/"
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/${MY_P}.tar.gz
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc"
DEPEND="doc? ( www-client/lynx )
	virtual/pam"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/${PV}
	sed -i -e 's:./configure:#./configure:' ${S}/bootstrap.sh
	sed -i -e "s:aclocal:aclocal -I ${WORKDIR}/${PV}/m4:" ${S}/bootstrap.sh

	sh bootstrap.sh
}

src_compile() {
	local myconf

	econf \
		$(use_enable doc lynx) \
		"--with-pammoddir=$(getpam_mod_dir)" \
		|| die
	emake || die
}

src_install() {
	make -C src DESTDIR=${D} install
	make -C man DESTDIR=${D} install

	rm -f ${D}/$(getpam_mod_dir)/pam_dotfile.la
	fperms 4111 /usr/sbin/pam-dotfile-helper

	dodoc README
	dohtml doc/*
}
