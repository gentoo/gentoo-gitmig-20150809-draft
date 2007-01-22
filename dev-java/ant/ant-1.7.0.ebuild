# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.7.0.ebuild,v 1.3 2007/01/22 17:11:01 corsair Exp $

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="~dev-java/ant-core-${PV}
	~dev-java/ant-tasks-${PV}"
RDEPEND="${DEPEND}"
