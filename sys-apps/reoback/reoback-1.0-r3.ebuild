# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reoback/reoback-1.0-r3.ebuild,v 1.3 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="Reoback Backup Solution"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/reoback/reoback-1.0_r3.tar.gz"
HOMEPAGE="http://reoback.penguinsoup.org/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"

RDEPEND=">=sys-apps/tar-1.13 
	>=dev-lang/perl-5.6.1 "
DEPEND="${RDEPEND}"

src_install() {
		
		# remove stupid cvs-dirs
		rm -r ${S}/CVS
		rm -r ${S}/conf/CVS
		rm -r ${S}/data
		rm -r ${S}/docs/CVS
		
		# make dirs and copy files
		dodir /etc/reoback
		dosbin ${S}/reoback.pl ${D}/usr/sbin/
		cp -ax ${S}/run_reoback.sh ${D}/etc/reoback/
		cp -ax ${S}/conf/* ${D}/etc/reoback/
		
		# fix permissions
		chmod 750 ${D}/usr/sbin/reoback.pl
		chmod 750 ${D}/etc/reoback/run_reoback.sh
		
		# install documentation
		cd ${S}/docs
		dodoc BUGS CHANGES INSTALL LICENSE MANUALS README TODO
}
