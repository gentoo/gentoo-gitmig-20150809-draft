# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/yaml/yaml-0.70.ebuild,v 1.1 2009/08/11 15:00:43 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
MY_PN="YAML"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="YAML Ain't Markup Language (tm)"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

SRC_TEST="do"
