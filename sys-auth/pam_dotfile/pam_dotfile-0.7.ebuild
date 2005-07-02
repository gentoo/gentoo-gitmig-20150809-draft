# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_dotfile/pam_dotfile-0.7.ebuild,v 1.1 2005/07/02 14:04:58 flameeyes Exp $

MY_P="${P/_beta/beta}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="pam module to allow password-storing in \$HOME/dotfiles"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/"
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="doc"
DEPEND="doc? ( www-client/lynx )
	>=sys-libs/pam-0.72"

src_compile() {
	local myconf

	if use doc; then
		myconf="--enable-lynx"
	else
		myconf="--disable-lynx"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	make -C src DESTDIR=${D} install
	make -C man DESTDIR=${D} install

	rm -f ${D}/lib/security/pam_dotfile.la
	fperms 4111 /usr/sbin/pam-dotfile-helper

	dodoc README
	dohtml doc/*
}
