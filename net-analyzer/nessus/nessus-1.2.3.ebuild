# Copyright 2000-2002 Achim Gottinger
# Distributed under the GPL by Gentoo Technologies, Inc.
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus/nessus-1.2.3.ebuild,v 1.1 2002/07/26 20:03:47 raker Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"

DEPEND="=net-analyzer/nessus-libraries-1.2.3
	=net-analyzer/libnasl-1.2.3
	=net-analyzer/nessus-core-1.2.3
	=net-analyzer/nessus-plugins-1.2.3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc -sparc64"
