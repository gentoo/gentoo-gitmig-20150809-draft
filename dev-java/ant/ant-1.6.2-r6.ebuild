# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.6.2-r6.ebuild,v 1.2 2004/09/13 21:27:45 axxo Exp $

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc sparc"
IUSE=""

DEPEND="=dev-java/ant-tasks-${PV}*
		=dev-java/ant-core-${PV}*"

