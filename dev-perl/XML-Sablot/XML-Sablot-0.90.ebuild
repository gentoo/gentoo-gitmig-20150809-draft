# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.90.ebuild,v 1.1 2002/05/06 17:45:11 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
#SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
#HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/xml-sab.act"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${PN}.${PV}.readme"

DEPEND="${DEPEND}
	>=app-text/sablotron-0.60"
