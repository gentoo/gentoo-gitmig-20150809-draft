# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-server-bin/systemimager-server-bin-3.0.1.ebuild,v 1.2 2003/11/06 01:01:48 mr_bones_ Exp $

MY_P="systemimager-server-3.0.1-4.noarch"

S=${WORKDIR}
DESCRIPTION="System imager server. Software that automates Linux installs, software distribution, and production deployment."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# Temporarily comment out because of repoman output
# DEPEND="app-arch/rpm2targz
#		app-admin/systemimager-common-bin
#		app-admin/systemimager-boot-bin"
#RDEPEND="${DEPEND}
#		dev-perl/AppConfig
#		dev-perl/XML-Simple"
src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {

#stuff in /usr
	dobin usr/bin/{mkautoinstallcd,mkautoinstalldiskette}
	dodir -p /usr/lib/systemimager/perl/SystemImager/
	insinto /usr/lib/systemimager/perl/SystemImager/
	doins usr/lib/systemimager/perl/SystemImager/Server.pm
	dosbin usr/sbin/{addclients,cpimage,getimage,mkautoinstallscript,mkbootserver,mkclientnetboot,mkdhcpserver,mkdhcpstatic,mkrsyncd_conf,mvimage,netbootmond,pushupdate,rmimage}
	doman usr/share/man/man5/*.gz
	doman usr/share/man/man8/*.gz
	dodoc usr/share/doc/systemimager-server-3.0.1/*

#stuff in /var
	dodir -p /var/lib/systemimager/{images,overrides,scripts}
	insinto /var/lib/systemimager/images
	doins var/lib/systemimager/images/*
	dodir -p /var/log/systemimager

#stuff in etc
	exeinto /etc/init.d
	doexe	etc/init.d/*
	dodir -p /etc/system/imager/{pxelinux.cfg,rsync_stubs}
	insinto /etc/systemimager/pxelinux.cfg
	doins	etc/systemimager/pxelinux.cfg/*
	insinto /etc/systemimager/rsync_stubs
	doins	etc/systemimager/rsync_stubs/*
	insinto /etc/systemimager
	doins	etc/systemimager/systemimager.conf

}

