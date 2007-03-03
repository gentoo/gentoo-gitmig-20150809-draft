# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.26.ebuild,v 1.16 2007/03/03 23:41:55 genone Exp $

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
	elog
	elog "Due to a change in documention in HTML-Mason, you will need to note"
	elog "that the documentation in the following files is no longer valid."
	elog "These files are present only if you had a previous install of "
	elog "HTML-Mason. Feel free to remove these docs from your system: "
	elog "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Interp.pod"
	elog "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/ApacheHandler.pod"
	elog "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Request.pod"
	elog "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Component.pod"
	elog "Where PERLVERSION is your version of perl (5.6.1, 5.8)"
	elog

}


