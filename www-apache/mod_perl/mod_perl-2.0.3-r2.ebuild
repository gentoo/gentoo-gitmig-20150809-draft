# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_perl/mod_perl-2.0.3-r2.ebuild,v 1.12 2008/05/13 14:25:50 jer Exp $

inherit apache-module perl-module eutils multilib

DESCRIPTION="An embedded Perl interpreter for Apache2"
SRC_URI="mirror://cpan/authors/id/P/PG/PGOLLUCCI/${P}.tar.gz"
HOMEPAGE="http://perl.apache.org/"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""
SLOT="1"

# see bug 30087 for why sudo is in here
DEPEND=">=dev-perl/Apache-Test-1.27
	>=virtual/perl-CGI-3.08
	>=dev-perl/Compress-Zlib-1.09
	app-admin/sudo"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="${S}/src/modules/perl/mod_perl.so"
APACHE2_MOD_CONF="${PV}/75_${PN}"
APACHE2_MOD_DEFINE="PERL"

DOCFILES="Changes INSTALL LICENSE README STATUS"

need_apache2

pkg_setup() {
	has_apache_threads_in dev-lang/perl ithreads
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# I am not entirely happy with this solution, but here's what's
	# going on here if someone wants to take a stab at another
	# approach.  When userpriv compilation is off, then the make
	# process drops to user "nobody" to run the test servers.  This
	# server is closed, and then the socket is rebound using
	# SO_REUSEADDR.  If the same user does this, there is no problem,
	# and the socket may be rebound immediately.  If a different user
	# (yes, in my testing, even root) attempts to rebind, it fails.
	# Since the "is the socket available yet" code and the
	# second-batch bind call both run as root, this will fail.

	# The upstream settings on my test machine cause the second batch
	# of tests to fail, believing the socket to still be in use.  I
	# tried patching various parts to make them run as the user
	# specified in $config->{vars}{user} using getpwnam, but found
	# this patch to be fairly intrusive, because the userid must be
	# restored and the patch must be applied to multiple places.

	# For now, we will simply extend the timeout in hopes that in the
	# non-userpriv case, the socket will clear from the kernel tables
	# normally, and the tests will proceed.

	# If anybody is still having problems, then commenting out "make
	# test" below should allow the software to build properly.

	# Robert Coie <rac@gentoo.org> 2003.05.06

	sed -i -e "s/sleep \$_/sleep \$_ << 2/" \
		"${S}"/Apache-Test/lib/Apache/TestServer.pm \
		|| die "problem editing TestServer.pm"

	# i wonder if this is the same sandbox issue, but TMPDIR is not
	# getting through via SetEnv. sneak it through here. Bug 172676
	epatch "${FILESDIR}"/RegistryCooker.patch

	# rendhalver - this got redone for 2.0.1 and seems to fix the make test problems
	epatch "${FILESDIR}"/mod_perl-2.0.1-sneak-tmpdir.patch
}

src_compile() {
	perl Makefile.PL \
		PREFIX="${D}"/usr \
		MP_TRACE=1 \
		MP_DEBUG=1 \
		MP_USE_DSO=1 \
		MP_APXS=${APXS}  \
		INSTALLDIRS=vendor </dev/null || die

	# reported that parallel make is broken in bug 30257
	emake -j1 || die
}

src_test() {
	# make test notes whether it is running as root, and drops
	# privileges all the way to "nobody" if so, so we must adjust
	# write permissions accordingly in this case.

	# IF YOU SUDO TO EMERGE AND HAVE !env_reset set testing will fail!
	if [[ "$(id -u)" == "0" ]]; then
		chown nobody:nobody "${WORKDIR}"
		chown nobody:nobody "${T}"
	fi

	# this does not || die because of bug 21325.  kudos to smark for
	# the idea of setting HOME.
	TMPDIR="${T}" HOME="${T}/" make test
}

src_install() {
	apache-module_src_install

	dodir "${APACHE_MODULESDIR}"
	make install \
		MODPERL_AP_LIBEXECDIR="${D}${APACHE_MODULESDIR}" \
		MODPERL_AP_INCLUDEDIR="${D}${APACHE_INCLUDEDIR}" \
		MP_INST_APACHE2=1 \
		INSTALLDIRS=vendor || die

	# rendhalver - fix the perllocal.pod that gets installed
	# it seems to me that this has been getting installed for ages
	fixlocalpod

	insinto "${APACHE_MODULES_CONFDIR}"
	doins "${FILESDIR}"/${PV}/apache2-mod_perl-startup.pl
	cp -pPR docs "${D}"/usr/share/doc/${PF}
	cp -pPR todo "${D}"/usr/share/doc/${PF}

	# this is an attempt to get @INC in line with /usr/bin/perl.
	# there is blib garbage in the mainstream one that can only be
	# useful during internal testing, so we wait until here and then
	# just go with a clean slate.  should be much easier to see what's
	# happening and revert if problematic.
	for FILE in $(grep -lr portage "${D}"/*|grep -v ".so"); do
		sed -i -e "s:${D}:/:g" ${FILE}
	done
}
