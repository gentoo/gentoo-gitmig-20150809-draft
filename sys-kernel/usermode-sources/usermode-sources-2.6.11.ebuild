# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.11.ebuild,v 1.1 2005/04/30 00:37:43 dsd Exp $

#K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

UML_VER="uml-${OKV}-bs4"

UNIPATCH_LIST="${DISTDIR}/${UML_VER}.patch.bz2
	${FILESDIR}/${PN}-2.6.74070.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0384.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0736.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0400.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0750.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0749.patch
	${FILESDIR}/${PN}-2.6.CAN-2005-0815.patch
	${FILESDIR}/${PN}-2.6.rose.patch"

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV}.tar.bz2
	http://www.user-mode-linux.org/~blaisorblade/patches/guest/${UML_VER}/${UML_VER}.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~x86"
IUSE=""

K_EXTRAEINFO="Since you are using UML, you may want to read the Gentoo Linux
Developer's guide to system testing with User-Mode Linux that
can be fount at http://www.gentoo.org/doc/en/uml.xml"

