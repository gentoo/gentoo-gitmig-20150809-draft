# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kpopup/kpopup-0.9.6_pre1.ebuild,v 1.1 2004/03/15 21:10:56 centic Exp $

inherit kde-base || die
need-kde 3

S=${WORKDIR}/${PN}-0.9.6pre1
LICENSE="GPL-2"
DESCRIPTION="An SMB Network Messenger"
SRC_URI="http://www.henschelsoft.de/${PN}/${PN}-0.9.6pre1.tar.gz"
HOMEPAGE="http://www.henschelsoft.de/kpopup.html"
KEYWORDS="~x86"

newdepend ">=net-fs/samba-2.2"

src_install()
{
#    cp ${S}/kpopup/Makefile ${S}/kpopup/Makefile.orig
#    sed -e "s:chmod u+s \$(kde_bindir)/kpopup:chmod u+s ${D}/opt/kde/3.1/bin/kpopup:" \
#	    ${S}/kpopup/Makefile.orig > ${S}/kpopup/Makefile

	make DESTDIR=${D} install || die "make install failed"
}
