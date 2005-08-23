# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.6.12-r2.ebuild,v 1.1 2005/08/23 14:41:08 dsd Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="13"
inherit kernel-2
detect_version

UML_VER="uml-2.6.12-bs11"
UNIPATCH_LIST="${DISTDIR}/${UML_VER}.patch.bz2"

#The uml-2.6.12-bs11 patch has a collision with the 2.6.12.3 patch
UNIPATCH_EXCLUDE="1003_linux-2.6.12.3.patch"

DESCRIPTION="Full sources for the User Mode Linux kernel"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI}
	http://www.user-mode-linux.org/~blaisorblade/patches/guest/${UML_VER}/${UML_VER}.patch.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
KEYWORDS="~x86"

K_EXTRAEINFO="Since you are using UML, you may want to read the Gentoo Linux
Developer's guide to system testing with User-Mode Linux that
can be found at http://www.gentoo.org/doc/en/uml.xml"

