# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoolkit/gentoolkit-0.1.1.ebuild,v 1.2 2002/02/03 04:58:55 aeoo Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Collection of unofficial administration scripts for Gentoo"
SRC_URI=""
HOMEPAGE="http://"

DEPEND=""
RDEPEND=">=dev-lang/python-2.0
	>=sys-devel/perl-5.6"

src_install () {
	dodir /usr/share/gentoolkit

	insinto /usr/share/gentoolkit
	doins ${FILESDIR}/coverage/histogram.awk

	dosbin ${FILESDIR}/coverage/total-coverage
	dosbin ${FILESDIR}/coverage/author-coverage

	dosbin ${FILESDIR}/lintool/lintool
	
	dosbin ${FILESDIR}/scripts/etc-update
	dosbin ${FILESDIR}/scripts/pkg-clean
	dosbin ${FILESDIR}/scripts/qpkg
	dosbin ${FILESDIR}/scripts/mkebuild
	dosbin ${FILESDIR}/scripts/emerge-webrsync
	dosbin ${FILESDIR}/scripts/epm

	dodoc ${FILESDIR}/lintool/checklist-for-ebuilds
	
}


pkg_postinst() {
    #notify user about new diff/sdiff mode for etc-update being the default
    if [ -f /usr/sbin/etc-update ]
    then
        echo
        echo "!! Warning: etc-update no longer defaults to using"
        echo "!!          vim diff mode!"
        echo "!!"
        echo "!!          Vim diff mode is still available with a quick"
        echo "!!          configuration change.  If you want to use vim"
        echo "!!          diff, just edit the top of the script as"
        echo "!!          appropriate."
        echo
    fi
}

