# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.26.ebuild,v 1.15 2007/01/20 14:41:19 mcummings Exp $

inherit perl-module

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=www-misc/libapreq-1.0-r2
	>=dev-perl/Params-Validate-0.24-r2
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.14
	virtual/perl-Scalar-List-Utils
	virtual/perl-CGI
	virtual/perl-File-Spec
	>=dev-perl/Cache-Cache-1.01
	dev-lang/perl"

mydoc="CREDITS UPGRADE"

src_install () {
	#This is a nasty fix for a sandbox violation that Mason wants to do
	mv -f install/delete_old_pods.pl install/delete_old_pods.pl2
	sed -e "s/use strict/exit()/" install/delete_old_pods.pl2 > install/delete_old_pods.pl
	perl-module_src_install
	dohtml htdocs/*
}


pkg_postinst() {
	einfo
	einfo "Due to a change in documention in HTML-Mason, you will need to note"
	einfo "that the documentation in the following files is no longer valid."
	einfo "These files are present only if you had a previous install of "
	einfo "HTML-Mason. Feel free to remove these docs from your system: "
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Interp.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/ApacheHandler.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Request.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Component.pod"
	einfo "Where PERLVERSION is your version of perl (5.6.1, 5.8)"
	einfo

}


