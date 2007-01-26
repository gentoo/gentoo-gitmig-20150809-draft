# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-swing/ant-swing-1.7.0.ebuild,v 1.5 2007/01/26 13:56:30 nelchael Exp $

inherit ant-tasks

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

src_unpack() {
	ant-tasks_src_unpack base
}
