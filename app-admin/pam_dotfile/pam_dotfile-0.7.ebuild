# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pam_dotfile/pam_dotfile-0.7.ebuild,v 1.2 2003/10/27 10:36:15 aliz Exp $

DESCRIPTION="pam_dotfile is a module for pam to allow password-storing in \$HOME/dotfiles"
HOMEPAGE="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/"

MY_P="${P/_beta/beta}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://www.stud.uni-hamburg.de/users/lennart/projects/pam_dotfile/${MY_P}.tar.gz"
DEPEND=">=sys-libs/pam-0.72"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_install() {
	make -C src DESTDIR=${D} install
	make -C man DESTDIR=${D} install

	rm -f ${D}/lib/security/pam_dotfile.la
	fperms 4111 /usr/sbin/pam-dotfile-helper

	dodoc README
	dohtml doc/*
}
