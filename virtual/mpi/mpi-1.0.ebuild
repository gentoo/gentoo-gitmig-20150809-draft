# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mpi/mpi-1.0.ebuild,v 1.6 2010/01/11 11:07:20 ulm Exp $

DESCRIPTION="Virtual for Message Passing Interface (MPI) implementation"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND="|| (
		sys-cluster/openmpi
		sys-cluster/mpich2
		sys-cluster/lam-mpi
	)"
DEPEND=""
