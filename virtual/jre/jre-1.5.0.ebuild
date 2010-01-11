# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.5.0.ebuild,v 1.12 2010/01/11 11:03:47 ulm Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.5"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.5.0*
		=dev-java/sun-jre-bin-1.5.0*
		=dev-java/diablo-jre-bin-1.5.0*
	)"
DEPEND=""
