# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.5.0.ebuild,v 1.14 2010/01/26 22:39:42 caster Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.5"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# Keep this list in sync with java-virtuals/jmx
# The keyword voodoo below is needed so that ppc(64) users will
# get a masked license warning for ibm-jdk-bin
# instead of (not useful) missing keyword warning for sun-jdk
# see #287615
RDEPEND="|| (
		amd64? ( =dev-java/sun-jdk-1.5.0* )
		x86? ( =dev-java/sun-jdk-1.5.0* )
		=dev-java/ibm-jdk-bin-1.5.0*
		=dev-java/jrockit-jdk-bin-1.5.0*
		=dev-java/diablo-jdk-1.5.0*
		=dev-java/apple-jdk-bin-1.5.0*
	)"
DEPEND=""
