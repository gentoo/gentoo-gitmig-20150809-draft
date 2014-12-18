# generated automatically by aclocal 1.11.6 -*- Autoconf -*-

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
# 2005, 2006, 2007, 2008, 2009, 2010, 2011 Free Software Foundation,
# Inc.
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# ===========================================================================
#       http://www.gnu.org/software/autoconf-archive/ax_boost_base.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_BASE([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the Boost C++ libraries of a particular version (or newer)
#
#   If no path to the installed boost library is given the macro searchs
#   under /usr, /usr/local, /opt and /opt/local and evaluates the
#   $BOOST_ROOT environment variable. Further documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_CPPFLAGS) / AC_SUBST(BOOST_LDFLAGS)
#
#   And sets:
#
#     HAVE_BOOST
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2009 Peter Adolphs
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 20

AC_DEFUN([AX_BOOST_BASE],
[
AC_ARG_WITH([boost],
  [AS_HELP_STRING([--with-boost@<:@=ARG@:>@],
    [use Boost library from a standard location (ARG=yes),
     from the specified location (ARG=<path>),
     or disable it (ARG=no)
     @<:@ARG=yes@:>@ ])],
    [
    if test "$withval" = "no"; then
        want_boost="no"
    elif test "$withval" = "yes"; then
        want_boost="yes"
        ac_boost_path=""
    else
        want_boost="yes"
        ac_boost_path="$withval"
    fi
    ],
    [want_boost="yes"])


AC_ARG_WITH([boost-libdir],
        AS_HELP_STRING([--with-boost-libdir=LIB_DIR],
        [Force given directory for boost libraries. Note that this will override library path detection, so use this parameter only if default library detection fails and you know exactly where your boost libraries are located.]),
        [
        if test -d "$withval"
        then
                ac_boost_lib_path="$withval"
        else
                AC_MSG_ERROR(--with-boost-libdir expected directory name)
        fi
        ],
        [ac_boost_lib_path=""]
)

if test "x$want_boost" = "xyes"; then
    boost_lib_version_req=ifelse([$1], ,1.20.0,$1)
    boost_lib_version_req_shorten=`expr $boost_lib_version_req : '\([[0-9]]*\.[[0-9]]*\)'`
    boost_lib_version_req_major=`expr $boost_lib_version_req : '\([[0-9]]*\)'`
    boost_lib_version_req_minor=`expr $boost_lib_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
    boost_lib_version_req_sub_minor=`expr $boost_lib_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
    if test "x$boost_lib_version_req_sub_minor" = "x" ; then
        boost_lib_version_req_sub_minor="0"
        fi
    WANT_BOOST_VERSION=`expr $boost_lib_version_req_major \* 100000 \+  $boost_lib_version_req_minor \* 100 \+ $boost_lib_version_req_sub_minor`
    AC_MSG_CHECKING(for boostlib >= $boost_lib_version_req)
    succeeded=no

    dnl On 64-bit systems check for system libraries in both lib64 and lib.
    dnl The former is specified by FHS, but e.g. Debian does not adhere to
    dnl this (as it rises problems for generic multi-arch support).
    dnl The last entry in the list is chosen by default when no libraries
    dnl are found, e.g. when only header-only libraries are installed!
    libsubdirs="lib"
    ax_arch=`uname -m`
    if test $ax_arch = x86_64 -o $ax_arch = ppc64 -o $ax_arch = s390x -o $ax_arch = sparc64; then
        libsubdirs="lib64 lib lib64"
    fi

    dnl first we check the system location for boost libraries
    dnl this location ist chosen if boost libraries are installed with the --layout=system option
    dnl or if you install boost with RPM
    if test "$ac_boost_path" != ""; then
        BOOST_CPPFLAGS="-I$ac_boost_path/include"
        for ac_boost_path_tmp in $libsubdirs; do
                if test -d "$ac_boost_path"/"$ac_boost_path_tmp" ; then
                        BOOST_LDFLAGS="-L$ac_boost_path/$ac_boost_path_tmp"
                        break
                fi
        done
    elif test "$cross_compiling" != yes; then
        for ac_boost_path_tmp in /usr /usr/local /opt /opt/local ; do
            if test -d "$ac_boost_path_tmp/include/boost" && test -r "$ac_boost_path_tmp/include/boost"; then
                for libsubdir in $libsubdirs ; do
                    if ls "$ac_boost_path_tmp/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                done
                BOOST_LDFLAGS="-L$ac_boost_path_tmp/$libsubdir"
                BOOST_CPPFLAGS="-I$ac_boost_path_tmp/include"
                break;
            fi
        done
    fi

    dnl overwrite ld flags if we have required special directory with
    dnl --with-boost-libdir parameter
    if test "$ac_boost_lib_path" != ""; then
       BOOST_LDFLAGS="-L$ac_boost_lib_path"
    fi

    CPPFLAGS_SAVED="$CPPFLAGS"
    CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
    export CPPFLAGS

    LDFLAGS_SAVED="$LDFLAGS"
    LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
    export LDFLAGS

    AC_REQUIRE([AC_PROG_CXX])
    AC_LANG_PUSH(C++)
        AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
    @%:@include <boost/version.hpp>
    ]], [[
    #if BOOST_VERSION >= $WANT_BOOST_VERSION
    // Everything is okay
    #else
    #  error Boost version is too old
    #endif
    ]])],[
        AC_MSG_RESULT(yes)
    succeeded=yes
    found_system=yes
        ],[
        ])
    AC_LANG_POP([C++])



    dnl if we found no boost with system layout we search for boost libraries
    dnl built and installed without the --layout=system option or for a staged(not installed) version
    if test "x$succeeded" != "xyes"; then
        _version=0
        if test "$ac_boost_path" != ""; then
            if test -d "$ac_boost_path" && test -r "$ac_boost_path"; then
                for i in `ls -d $ac_boost_path/include/boost-* 2>/dev/null`; do
                    _version_tmp=`echo $i | sed "s#$ac_boost_path##" | sed 's/\/include\/boost-//' | sed 's/_/./'`
                    V_CHECK=`expr $_version_tmp \> $_version`
                    if test "$V_CHECK" = "1" ; then
                        _version=$_version_tmp
                    fi
                    VERSION_UNDERSCORE=`echo $_version | sed 's/\./_/'`
                    BOOST_CPPFLAGS="-I$ac_boost_path/include/boost-$VERSION_UNDERSCORE"
                done
            fi
        else
            if test "$cross_compiling" != yes; then
                for ac_boost_path in /usr /usr/local /opt /opt/local ; do
                    if test -d "$ac_boost_path" && test -r "$ac_boost_path"; then
                        for i in `ls -d $ac_boost_path/include/boost-* 2>/dev/null`; do
                            _version_tmp=`echo $i | sed "s#$ac_boost_path##" | sed 's/\/include\/boost-//' | sed 's/_/./'`
                            V_CHECK=`expr $_version_tmp \> $_version`
                            if test "$V_CHECK" = "1" ; then
                                _version=$_version_tmp
                                best_path=$ac_boost_path
                            fi
                        done
                    fi
                done

                VERSION_UNDERSCORE=`echo $_version | sed 's/\./_/'`
                BOOST_CPPFLAGS="-I$best_path/include/boost-$VERSION_UNDERSCORE"
                if test "$ac_boost_lib_path" = ""; then
                    for libsubdir in $libsubdirs ; do
                        if ls "$best_path/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                    done
                    BOOST_LDFLAGS="-L$best_path/$libsubdir"
                fi
            fi

            if test "x$BOOST_ROOT" != "x"; then
                for libsubdir in $libsubdirs ; do
                    if ls "$BOOST_ROOT/stage/$libsubdir/libboost_"* >/dev/null 2>&1 ; then break; fi
                done
                if test -d "$BOOST_ROOT" && test -r "$BOOST_ROOT" && test -d "$BOOST_ROOT/stage/$libsubdir" && test -r "$BOOST_ROOT/stage/$libsubdir"; then
                    version_dir=`expr //$BOOST_ROOT : '.*/\(.*\)'`
                    stage_version=`echo $version_dir | sed 's/boost_//' | sed 's/_/./g'`
                        stage_version_shorten=`expr $stage_version : '\([[0-9]]*\.[[0-9]]*\)'`
                    V_CHECK=`expr $stage_version_shorten \>\= $_version`
                    if test "$V_CHECK" = "1" -a "$ac_boost_lib_path" = "" ; then
                        AC_MSG_NOTICE(We will use a staged boost library from $BOOST_ROOT)
                        BOOST_CPPFLAGS="-I$BOOST_ROOT"
                        BOOST_LDFLAGS="-L$BOOST_ROOT/stage/$libsubdir"
                    fi
                fi
            fi
        fi

        CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
        export CPPFLAGS
        LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
        export LDFLAGS

        AC_LANG_PUSH(C++)
            AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        @%:@include <boost/version.hpp>
        ]], [[
        #if BOOST_VERSION >= $WANT_BOOST_VERSION
        // Everything is okay
        #else
        #  error Boost version is too old
        #endif
        ]])],[
            AC_MSG_RESULT(yes)
        succeeded=yes
        found_system=yes
            ],[
            ])
        AC_LANG_POP([C++])
    fi

    if test "$succeeded" != "yes" ; then
        if test "$_version" = "0" ; then
            AC_MSG_NOTICE([[We could not detect the boost libraries (version $boost_lib_version_req_shorten or higher). If you have a staged boost library (still not installed) please specify \$BOOST_ROOT in your environment and do not give a PATH to --with-boost option.  If you are sure you have boost installed, then check your version number looking in <boost/version.hpp>. See http://randspringer.de/boost for more documentation.]])
        else
            AC_MSG_NOTICE([Your boost libraries seems to old (version $_version).])
        fi
        # execute ACTION-IF-NOT-FOUND (if present):
        ifelse([$3], , :, [$3])
    else
        AC_SUBST(BOOST_CPPFLAGS)
        AC_SUBST(BOOST_LDFLAGS)
        AC_DEFINE(HAVE_BOOST,,[define if the Boost library is available])
        # execute ACTION-IF-FOUND (if present):
        ifelse([$2], , :, [$2])
    fi

    CPPFLAGS="$CPPFLAGS_SAVED"
    LDFLAGS="$LDFLAGS_SAVED"
fi

])

# ===========================================================================
#     http://www.gnu.org/software/autoconf-archive/ax_boost_signals.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_SIGNALS
#
# DESCRIPTION
#
#   Test for Signals library from the Boost C++ libraries. The macro
#   requires a preceding call to AX_BOOST_BASE. Further documentation is
#   available at <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_SIGNALS_LIB)
#
#   And sets:
#
#     HAVE_BOOST_SIGNALS
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2008 Michael Tindal
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 19

AC_DEFUN([AX_BOOST_SIGNALS],
[
	AC_ARG_WITH([boost-signals],
	AS_HELP_STRING([--with-boost-signals@<:@=special-lib@:>@],
                   [use the Signals library from boost - it is possible to specify a certain library for the linker
                        e.g. --with-boost-signals=boost_signals-gcc-mt-d ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_signals_lib=""
        else
		    want_boost="yes"
		ax_boost_user_signals_lib="$withval"
		fi
        ],
        [want_boost="yes"]
	)

	if test "x$want_boost" = "xyes"; then
        AC_REQUIRE([AC_PROG_CC])
		CPPFLAGS_SAVED="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
		export CPPFLAGS

		LDFLAGS_SAVED="$LDFLAGS"
		LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
		export LDFLAGS

        AC_CACHE_CHECK(whether the Boost::Signals library is available,
					   ax_cv_boost_signals,
        [AC_LANG_PUSH([C++])
		 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[@%:@include <boost/signal.hpp>
											]],
                                  [[boost::signal<void ()> sig;
                                    return 0;
                                  ]])],
                           ax_cv_boost_signals=yes, ax_cv_boost_signals=no)
         AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_signals" = "xyes"; then
			AC_DEFINE(HAVE_BOOST_SIGNALS,,[define if the Boost::Signals library is available])
            BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`
            if test "x$ax_boost_user_signals_lib" = "x"; then
                for libextension in `ls $BOOSTLIBDIR/libboost_signals*.so* $BOOSTLIBDIR/libboost_signals*.a* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^lib\(boost_signals.*\)\.so.*$;\1;' -e 's;^lib\(boost_signals.*\)\.a*$;\1;'` ; do
                     ax_lib=${libextension}
				    AC_CHECK_LIB($ax_lib, exit,
                                 [BOOST_SIGNALS_LIB="-l$ax_lib"; AC_SUBST(BOOST_SIGNALS_LIB) link_signals="yes"; break],
                                 [link_signals="no"])
				done
                if test "x$link_signals" != "xyes"; then
                for libextension in `ls $BOOSTLIBDIR/boost_signals*.{dll,a}* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^\(boost_signals.*\)\.dll.*$;\1;' -e 's;^\(boost_signals.*\)\.a*$;\1;'` ; do
                     ax_lib=${libextension}
				    AC_CHECK_LIB($ax_lib, exit,
                                 [BOOST_SIGNALS_LIB="-l$ax_lib"; AC_SUBST(BOOST_SIGNALS_LIB) link_signals="yes"; break],
                                 [link_signals="no"])
				done
                fi

            else
               for ax_lib in $ax_boost_user_signals_lib boost_signals-$ax_boost_user_signals_lib; do
				      AC_CHECK_LIB($ax_lib, main,
                                   [BOOST_SIGNALS_LIB="-l$ax_lib"; AC_SUBST(BOOST_SIGNALS_LIB) link_signals="yes"; break],
                                   [link_signals="no"])
                  done

            fi
            if test "x$ax_lib" = "x"; then
                AC_MSG_ERROR(Could not find a version of the library!)
            fi
			if test "x$link_signals" != "xyes"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
	LDFLAGS="$LDFLAGS_SAVED"
	fi
])

# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_boost_system.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_SYSTEM
#
# DESCRIPTION
#
#   Test for System library from the Boost C++ libraries. The macro requires
#   a preceding call to AX_BOOST_BASE. Further documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_SYSTEM_LIB)
#
#   And sets:
#
#     HAVE_BOOST_SYSTEM
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2008 Michael Tindal
#   Copyright (c) 2008 Daniel Casimiro <dan.casimiro@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 14

AC_DEFUN([AX_BOOST_SYSTEM],
[
	AC_ARG_WITH([boost-system],
	AS_HELP_STRING([--with-boost-system@<:@=special-lib@:>@],
                   [use the System library from boost - it is possible to specify a certain library for the linker
                        e.g. --with-boost-system=boost_system-gcc-mt ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_system_lib=""
        else
		    want_boost="yes"
		ax_boost_user_system_lib="$withval"
		fi
        ],
        [want_boost="yes"]
	)

	if test "x$want_boost" = "xyes"; then
        AC_REQUIRE([AC_PROG_CC])
        AC_REQUIRE([AC_CANONICAL_BUILD])
		CPPFLAGS_SAVED="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
		export CPPFLAGS

		LDFLAGS_SAVED="$LDFLAGS"
		LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
		export LDFLAGS

        AC_CACHE_CHECK(whether the Boost::System library is available,
					   ax_cv_boost_system,
        [AC_LANG_PUSH([C++])
			 CXXFLAGS_SAVE=$CXXFLAGS

			 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[@%:@include <boost/system/error_code.hpp>]],
                                   [[boost::system::system_category]])],
                   ax_cv_boost_system=yes, ax_cv_boost_system=no)
			 CXXFLAGS=$CXXFLAGS_SAVE
             AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_system" = "xyes"; then
			AC_SUBST(BOOST_CPPFLAGS)

			AC_DEFINE(HAVE_BOOST_SYSTEM,,[define if the Boost::System library is available])
            BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`

			LDFLAGS_SAVE=$LDFLAGS
            if test "x$ax_boost_user_system_lib" = "x"; then
                for libextension in `ls $BOOSTLIBDIR/libboost_system*.so* $BOOSTLIBDIR/libboost_system*.a* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^lib\(boost_system.*\)\.so.*$;\1;' -e 's;^lib\(boost_system.*\)\.a*$;\1;'` ; do
                     ax_lib=${libextension}
				    AC_CHECK_LIB($ax_lib, exit,
                                 [BOOST_SYSTEM_LIB="-l$ax_lib"; AC_SUBST(BOOST_SYSTEM_LIB) link_system="yes"; break],
                                 [link_system="no"])
				done
                if test "x$link_system" != "xyes"; then
                for libextension in `ls $BOOSTLIBDIR/boost_system*.{dll,a}* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^\(boost_system.*\)\.dll.*$;\1;' -e 's;^\(boost_system.*\)\.a*$;\1;'` ; do
                     ax_lib=${libextension}
				    AC_CHECK_LIB($ax_lib, exit,
                                 [BOOST_SYSTEM_LIB="-l$ax_lib"; AC_SUBST(BOOST_SYSTEM_LIB) link_system="yes"; break],
                                 [link_system="no"])
				done
                fi

            else
               for ax_lib in $ax_boost_user_system_lib boost_system-$ax_boost_user_system_lib; do
				      AC_CHECK_LIB($ax_lib, exit,
                                   [BOOST_SYSTEM_LIB="-l$ax_lib"; AC_SUBST(BOOST_SYSTEM_LIB) link_system="yes"; break],
                                   [link_system="no"])
                  done

            fi
            if test "x$ax_lib" = "x"; then
                AC_MSG_ERROR(Could not find a version of the library!)
            fi
			if test "x$link_system" = "xno"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
	LDFLAGS="$LDFLAGS_SAVED"
	fi
])

# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_with_curses.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_WITH_CURSES
#
# DESCRIPTION
#
#   This macro checks whether a SysV or X/Open-compatible Curses library is
#   present, along with the associated header file.  The NcursesW
#   (wide-character) library is searched for first, followed by Ncurses,
#   then the system-default plain Curses.  The first library found is the
#   one returned.
#
#   The following options are understood: --with-ncursesw, --with-ncurses,
#   --without-ncursesw, --without-ncurses.  The "--with" options force the
#   macro to use that particular library, terminating with an error if not
#   found.  The "--without" options simply skip the check for that library.
#   The effect on the search pattern is:
#
#     (no options)                           - NcursesW, Ncurses, Curses
#     --with-ncurses     --with-ncursesw     - NcursesW only [*]
#     --without-ncurses  --with-ncursesw     - NcursesW only [*]
#                        --with-ncursesw     - NcursesW only [*]
#     --with-ncurses     --without-ncursesw  - Ncurses only [*]
#     --with-ncurses                         - NcursesW, Ncurses [**]
#     --without-ncurses  --without-ncursesw  - Curses only
#                        --without-ncursesw  - Ncurses, Curses
#     --without-ncurses                      - NcursesW, Curses
#
#   [*]  If the library is not found, abort the configure script.
#
#   [**] If the second library (Ncurses) is not found, abort configure.
#
#   The following preprocessor symbols may be defined by this macro if the
#   appropriate conditions are met:
#
#     HAVE_CURSES             - if any SysV or X/Open Curses library found
#     HAVE_CURSES_ENHANCED    - if library supports X/Open Enhanced functions
#     HAVE_CURSES_COLOR       - if library supports color (enhanced functions)
#     HAVE_CURSES_OBSOLETE    - if library supports certain obsolete features
#     HAVE_NCURSESW           - if NcursesW (wide char) library is to be used
#     HAVE_NCURSES            - if the Ncurses library is to be used
#
#     HAVE_CURSES_H           - if <curses.h> is present and should be used
#     HAVE_NCURSESW_H         - if <ncursesw.h> should be used
#     HAVE_NCURSES_H          - if <ncurses.h> should be used
#     HAVE_NCURSESW_CURSES_H  - if <ncursesw/curses.h> should be used
#     HAVE_NCURSES_CURSES_H   - if <ncurses/curses.h> should be used
#
#   (These preprocessor symbols are discussed later in this document.)
#
#   The following output variable is defined by this macro; it is precious
#   and may be overridden on the ./configure command line:
#
#     CURSES_LIB  - library to add to xxx_LDADD
#
#   The library listed in CURSES_LIB is NOT added to LIBS by default. You
#   need to add CURSES_LIB to the appropriate xxx_LDADD line in your
#   Makefile.am.  For example:
#
#     prog_LDADD = @CURSES_LIB@
#
#   If CURSES_LIB is set on the configure command line (such as by running
#   "./configure CURSES_LIB=-lmycurses"), then the only header searched for
#   is <curses.h>.  The user may use the CPPFLAGS precious variable to
#   override the standard #include search path.  If the user needs to
#   specify an alternative path for a library (such as for a non-standard
#   NcurseW), the user should use the LDFLAGS variable.
#
#   The following shell variables may be defined by this macro:
#
#     ax_cv_curses           - set to "yes" if any Curses library found
#     ax_cv_curses_enhanced  - set to "yes" if Enhanced functions present
#     ax_cv_curses_color     - set to "yes" if color functions present
#     ax_cv_curses_obsolete  - set to "yes" if obsolete features present
#
#     ax_cv_ncursesw      - set to "yes" if NcursesW library found
#     ax_cv_ncurses       - set to "yes" if Ncurses library found
#     ax_cv_plaincurses   - set to "yes" if plain Curses library found
#     ax_cv_curses_which  - set to "ncursesw", "ncurses", "plaincurses" or "no"
#
#   These variables can be used in your configure.ac to determine the level
#   of support you need from the Curses library.  For example, if you must
#   have either Ncurses or NcursesW, you could include:
#
#     AX_WITH_CURSES
#     if test "x$ax_cv_ncursesw" != xyes && test "x$ax_cv_ncurses" != xyes; then
#         AX_MSG_ERROR([requires either NcursesW or Ncurses library])
#     fi
#
#   If any Curses library will do (but one must be present and must support
#   color), you could use:
#
#     AX_WITH_CURSES
#     if test "x$ax_cv_curses" != xyes || test "x$ax_cv_curses_color" != xyes; then
#         AC_MSG_ERROR([requires an X/Open-compatible Curses library with color])
#     fi
#
#   Certain preprocessor symbols and shell variables defined by this macro
#   can be used to determine various features of the Curses library.  In
#   particular, HAVE_CURSES and ax_cv_curses are defined if the Curses
#   library found conforms to the traditional SysV and/or X/Open Base Curses
#   definition.  Any working Curses library conforms to this level.
#
#   HAVE_CURSES_ENHANCED and ax_cv_curses_enhanced are defined if the
#   library supports the X/Open Enhanced Curses definition.  In particular,
#   the wide-character types attr_t, cchar_t and wint_t, the functions
#   wattr_set() and wget_wch() and the macros WA_NORMAL and _XOPEN_CURSES
#   are checked.  The Ncurses library does NOT conform to this definition,
#   although NcursesW does.
#
#   HAVE_CURSES_COLOR and ax_cv_curses_color are defined if the library
#   supports color functions and macros such as COLOR_PAIR, A_COLOR,
#   COLOR_WHITE, COLOR_RED and init_pair().  These are NOT part of the
#   X/Open Base Curses definition, but are part of the Enhanced set of
#   functions.  The Ncurses library DOES support these functions, as does
#   NcursesW.
#
#   HAVE_CURSES_OBSOLETE and ax_cv_curses_obsolete are defined if the
#   library supports certain features present in SysV and BSD Curses but not
#   defined in the X/Open definition.  In particular, the functions
#   getattrs(), getcurx() and getmaxx() are checked.
#
#   To use the HAVE_xxx_H preprocessor symbols, insert the following into
#   your system.h (or equivalent) header file:
#
#     #if defined(HAVE_NCURSESW_CURSES_H)
#     #  include <ncursesw/curses.h>
#     #elif defined(HAVE_NCURSESW_H)
#     #  include <ncursesw.h>
#     #elif defined(HAVE_NCURSES_CURSES_H)
#     #  include <ncurses/curses.h>
#     #elif defined(HAVE_NCURSES_H)
#     #  include <ncurses.h>
#     #elif defined(HAVE_CURSES_H)
#     #  include <curses.h>
#     #else
#     #  error "SysV or X/Open-compatible Curses header file required"
#     #endif
#
#   For previous users of this macro: you should not need to change anything
#   in your configure.ac or Makefile.am, as the previous (serial 10)
#   semantics are still valid.  However, you should update your system.h (or
#   equivalent) header file to the fragment shown above. You are encouraged
#   also to make use of the extended functionality provided by this version
#   of AX_WITH_CURSES, as well as in the additional macros
#   AX_WITH_CURSES_PANEL, AX_WITH_CURSES_MENU and AX_WITH_CURSES_FORM.
#
# LICENSE
#
#   Copyright (c) 2009 Mark Pulford <mark@kyne.com.au>
#   Copyright (c) 2009 Damian Pietras <daper@daper.net>
#   Copyright (c) 2011 Reuben Thomas <rrt@sc3d.org>
#   Copyright (c) 2011 John Zaitseff <J.Zaitseff@zap.org.au>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 12

AU_ALIAS([MP_WITH_CURSES], [AX_WITH_CURSES])
AC_DEFUN([AX_WITH_CURSES], [
    AC_ARG_VAR([CURSES_LIB], [linker library for Curses, e.g. -lcurses])
    AC_ARG_WITH([ncurses], [AS_HELP_STRING([--with-ncurses],
        [force the use of Ncurses or NcursesW])],
        [], [with_ncurses=check])
    AC_ARG_WITH([ncursesw], [AS_HELP_STRING([--without-ncursesw],
        [do not use NcursesW (wide character support)])],
        [], [with_ncursesw=check])

    ax_saved_LIBS=$LIBS
    AS_IF([test "x$with_ncurses" = xyes || test "x$with_ncursesw" = xyes],
        [ax_with_plaincurses=no], [ax_with_plaincurses=check])

    ax_cv_curses_which=no

    # Test for NcursesW

    AS_IF([test "x$CURSES_LIB" = x && test "x$with_ncursesw" != xno], [
        LIBS="$ax_saved_LIBS -lncursesw"

        AC_CACHE_CHECK([for NcursesW wide-character library], [ax_cv_ncursesw], [
            AC_LINK_IFELSE([AC_LANG_CALL([], [initscr])],
                [ax_cv_ncursesw=yes], [ax_cv_ncursesw=no])
        ])
        AS_IF([test "x$ax_cv_ncursesw" = xno && test "x$with_ncursesw" = xyes], [
            AC_MSG_ERROR([--with-ncursesw specified but could not find NcursesW library])
        ])

        AS_IF([test "x$ax_cv_ncursesw" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=ncursesw
            CURSES_LIB="-lncursesw"
            AC_DEFINE([HAVE_NCURSESW], [1], [Define to 1 if the NcursesW library is present])
            AC_DEFINE([HAVE_CURSES],   [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            AC_CACHE_CHECK([for working ncursesw/curses.h], [ax_cv_header_ncursesw_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncursesw/curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncursesw_curses_h=yes],
                    [ax_cv_header_ncursesw_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncursesw_curses_h" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED],   [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],      [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE],   [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSESW_CURSES_H], [1], [Define to 1 if <ncursesw/curses.h> is present])
            ])

            AC_CACHE_CHECK([for working ncursesw.h], [ax_cv_header_ncursesw_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncursesw.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncursesw_h=yes],
                    [ax_cv_header_ncursesw_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncursesw_h" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSESW_H],      [1], [Define to 1 if <ncursesw.h> is present])
            ])

            AC_CACHE_CHECK([for working ncurses.h], [ax_cv_header_ncurses_h_with_ncursesw], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncurses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncurses_h_with_ncursesw=yes],
                    [ax_cv_header_ncurses_h_with_ncursesw=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_h_with_ncursesw" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_H],       [1], [Define to 1 if <ncurses.h> is present])
            ])

            AS_IF([test "x$ax_cv_header_ncursesw_curses_h" = xno && test "x$ax_cv_header_ncursesw_h" = xno && test "x$ax_cv_header_ncurses_h_with_ncursesw" = xno], [
                AC_MSG_WARN([could not find a working ncursesw/curses.h, ncursesw.h or ncurses.h])
            ])
        ])
    ])

    # Test for Ncurses

    AS_IF([test "x$CURSES_LIB" = x && test "x$with_ncurses" != xno && test "x$ax_cv_curses_which" = xno], [
        LIBS="$ax_saved_LIBS -lncurses"

        AC_CACHE_CHECK([for Ncurses library], [ax_cv_ncurses], [
            AC_LINK_IFELSE([AC_LANG_CALL([], [initscr])],
                [ax_cv_ncurses=yes], [ax_cv_ncurses=no])
        ])
        AS_IF([test "x$ax_cv_ncurses" = xno && test "x$with_ncurses" = xyes], [
            AC_MSG_ERROR([--with-ncurses specified but could not find Ncurses library])
        ])

        AS_IF([test "x$ax_cv_ncurses" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=ncurses
            CURSES_LIB="-lncurses"
            AC_DEFINE([HAVE_NCURSES], [1], [Define to 1 if the Ncurses library is present])
            AC_DEFINE([HAVE_CURSES],  [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            AC_CACHE_CHECK([for working ncurses/curses.h], [ax_cv_header_ncurses_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <ncurses/curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                    ]])],
                    [ax_cv_header_ncurses_curses_h=yes],
                    [ax_cv_header_ncurses_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_curses_h" = xyes], [
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_COLOR],     [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE],  [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_CURSES_H], [1], [Define to 1 if <ncurses/curses.h> is present])
            ])

            AC_CACHE_CHECK([for working ncurses.h], [ax_cv_header_ncurses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <ncurses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                    ]])],
                    [ax_cv_header_ncurses_h=yes],
                    [ax_cv_header_ncurses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_h" = xyes], [
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_H],       [1], [Define to 1 if <ncurses.h> is present])
            ])

            AS_IF([test "x$ax_cv_header_ncurses_curses_h" = xno && test "x$ax_cv_header_ncurses_h" = xno], [
                AC_MSG_WARN([could not find a working ncurses/curses.h or ncurses.h])
            ])
        ])
    ])

    # Test for plain Curses (or if CURSES_LIB was set by user)

    AS_IF([test "x$with_plaincurses" != xno && test "x$ax_cv_curses_which" = xno], [
        AS_IF([test "x$CURSES_LIB" != x], [
            LIBS="$ax_saved_LIBS $CURSES_LIB"
        ], [
            LIBS="$ax_saved_LIBS -lcurses"
        ])

        AC_CACHE_CHECK([for Curses library], [ax_cv_plaincurses], [
            AC_LINK_IFELSE([AC_LANG_CALL([], [initscr])],
                [ax_cv_plaincurses=yes], [ax_cv_plaincurses=no])
        ])

        AS_IF([test "x$ax_cv_plaincurses" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=plaincurses
            AS_IF([test "x$CURSES_LIB" = x], [
                CURSES_LIB="-lcurses"
            ])
            AC_DEFINE([HAVE_CURSES], [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            # Check for base conformance (and header file)

            AC_CACHE_CHECK([for working curses.h], [ax_cv_header_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        initscr();
                    ]])],
                    [ax_cv_header_curses_h=yes],
                    [ax_cv_header_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_curses_h" = xyes], [
                AC_DEFINE([HAVE_CURSES_H], [1], [Define to 1 if <curses.h> is present])

                # Check for X/Open Enhanced conformance

                AC_CACHE_CHECK([for X/Open Enhanced Curses conformance], [ax_cv_plaincurses_enhanced], [
                    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                            @%:@define _XOPEN_SOURCE_EXTENDED 1
                            @%:@include <curses.h>
                            @%:@ifndef _XOPEN_CURSES
                            @%:@error "this Curses library is not enhanced"
                            "this Curses library is not enhanced"
                            @%:@endif
                        ]], [[
                            chtype a = A_BOLD;
                            int b = KEY_LEFT;
                            chtype c = COLOR_PAIR(1) & A_COLOR;
                            attr_t d = WA_NORMAL;
                            cchar_t e;
                            wint_t f;
                            initscr();
                            init_pair(1, COLOR_WHITE, COLOR_RED);
                            wattr_set(stdscr, d, 0, NULL);
                            wget_wch(stdscr, &f);
                        ]])],
                        [ax_cv_plaincurses_enhanced=yes],
                        [ax_cv_plaincurses_enhanced=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_enhanced" = xyes], [
                    ax_cv_curses_enhanced=yes
                    ax_cv_curses_color=yes
                    AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                    AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                ])

                # Check for color functions

                AC_CACHE_CHECK([for Curses color functions], [ax_cv_plaincurses_color], [
                    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <curses.h>
                        ]], [[
                            chtype a = A_BOLD;
                            int b = KEY_LEFT;
                            chtype c = COLOR_PAIR(1) & A_COLOR;
                            initscr();
                            init_pair(1, COLOR_WHITE, COLOR_RED);
                        ]])],
                        [ax_cv_plaincurses_color=yes],
                        [ax_cv_plaincurses_color=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_color" = xyes], [
                    ax_cv_curses_color=yes
                    AC_DEFINE([HAVE_CURSES_COLOR], [1], [Define to 1 if library supports color (enhanced functions)])
                ])

                # Check for obsolete functions

                AC_CACHE_CHECK([for obsolete Curses functions], [ax_cv_plaincurses_obsolete], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                    ]])],
                    [ax_cv_plaincurses_obsolete=yes],
                    [ax_cv_plaincurses_obsolete=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_obsolete" = xyes], [
                    ax_cv_curses_obsolete=yes
                    AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                ])
            ])

            AS_IF([test "x$ax_cv_header_curses_h" = xno], [
                AC_MSG_WARN([could not find a working curses.h])
            ])
        ])
    ])

    AS_IF([test "x$ax_cv_curses"          != xyes], [ax_cv_curses=no])
    AS_IF([test "x$ax_cv_curses_enhanced" != xyes], [ax_cv_curses_enhanced=no])
    AS_IF([test "x$ax_cv_curses_color"    != xyes], [ax_cv_curses_color=no])
    AS_IF([test "x$ax_cv_curses_obsolete" != xyes], [ax_cv_curses_obsolete=no])

    LIBS=$ax_saved_LIBS
])dnl
