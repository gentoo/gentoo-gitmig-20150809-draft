# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mpi/mpi-2.0.ebuild,v 1.1 2009/06/26 22:57:13 jsbronder Exp $

EAPI=2

DESCRIPTION="Virtual for Message Passing Interface (MPI) v2.0 implementation"
HOMEPAGE="http://www.gentoo.org/proj/en/cluster/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cxx fortran"

RDEPEND="|| (
	sys-cluster/openmpi[cxx?,fortran?]
	sys-cluster/mpich2[cxx?,fortran?]
	sys-cluster/lam-mpi[fortran?]
)"

DEPEND=""
