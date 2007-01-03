# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.18-r1.ebuild,v 1.1 2007/01/03 03:59:08 dang Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="8"
inherit kernel-2
detect_version

UML_VER="uml-2.6.18.1-bb2"
UNIPATCH_LIST="${FILESDIR}/uml-2.6.18-genpatches-8-prep.patch
	${DISTDIR}/${UML_VER}.patch.bz2"
UNIPATCH_STRICTORDER="yes"

DESCRIPTION="Full sources for the User Mode Linux kernel"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI}
	http://www.user-mode-linux.org/~blaisorblade/patches/guest/${UML_VER}/${UML_VER}.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~amd64 ~x86"

K_EXTRAEINFO="Since you are using UML, you may want to read the Gentoo Linux
Developer's guide to system testing with User-Mode Linux that
can be found at http://www.gentoo.org/doc/en/uml.xml"
