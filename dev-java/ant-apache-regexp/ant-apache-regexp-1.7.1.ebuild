# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-regexp/ant-apache-regexp-1.7.1.ebuild,v 1.3 2008/12/20 19:50:35 ken69267 Exp $

EAPI=1

ANT_TASK_DEPNAME="jakarta-regexp-1.4"

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ppc ~ppc64 ~x86 ~x86-fbsd"

DEPEND=">=dev-java/jakarta-regexp-1.4-r1:1.4"
RDEPEND="${DEPEND}"
